
clearvars
%initializes the table
T = readtable("dirty_cafe_sales-1.csv", TextType="string");

% Treat bad entries as missing
T = standardizeMissing(T, ["", "NA", "N/A", "null", "NULL", "-", "."]);

% Convert numeric collumns to strings
T.Quantity = str2double(string(T.Quantity));
T.PricePerUnit = str2double(string(T.PricePerUnit));
T.TotalSpent = str2double(string(T.TotalSpent));

% Recalculate TotalSpent when something is missing
calcTotal = T.Quantity .* T.PricePerUnit;
badTotal = isnan(T.TotalSpent) | abs(T.TotalSpent - calcTotal) > 1e-6;
T.TotalSpent(badTotal) = calcTotal(badTotal);

% Remove all values without Totalspent
Tclean = T(~isnan(T.TotalSpent), :);

% Summary statistics for TotalSpent
spent = Tclean.TotalSpent;

    
    meanValue = mean(spent, "omitnan");
    stdValue = std(spent, "omitnan");
    minValue = min(spent, [], "omitnan");
    medianValue= median(spent, "omitnan");
    maxValue=max(spent, [], "omitnan") ;
    SumValue=sum(spent, "omitnan");
    
    disp(["meanValue stdValue minValue medianValue maxValue SumValue" ...
        ])



% Mostly sold item
validItem = ~ismissing(Tclean.Item);
[itemGroups, itemNames] = findgroups(Tclean.Item(validItem));
transactionCounts = splitapply(@numel, Tclean.Item(validItem), itemGroups);
totalQuantities = splitapply(@sum, Tclean.Quantity(validItem), itemGroups);

[~, idxMostTransactions] = max(transactionCounts);
[~, idxGreatestQty] = max(totalQuantities);

fprintf("Most frequently sold item: %s\n", itemNames(idxMostTransactions))
fprintf("Item sold in greatest total quantity: %s\n", itemNames(idxGreatestQty))

% Find payment method column
vars = string(Tclean.Properties.VariableNames);
normVars = lower(regexprep(vars, "[^a-z0-9]", ""));

itemIdx = find(contains(normVars, "item"), 1, "first");
payIdx  = find(contains(normVars, "paymentmethod") | contains(normVars, "payment"), 1, "first");

if isempty(payIdx)
    error("No payment-method column was found in the table.");
end

itemVar = vars(itemIdx);
payVar  = vars(payIdx);

% Most preferred payment method, excluding missing values
validPay = ~ismissing(Tclean.(payVar));
[payGroups, payNames] = findgroups(Tclean.(payVar)(validPay));
payCounts = splitapply(@numel, Tclean.(payVar)(validPay), payGroups);

[~, idxTopPay] = max(payCounts);
fprintf("Most preferred payment method: %s\n", payNames(idxTopPay))

% Total spent per item
[itemGroups2, itemNames2] = findgroups(Tclean.(itemVar));
totalSpentPerItem = splitapply(@sum, Tclean.TotalSpent, itemGroups2);

figure
bar(categorical(itemNames2), totalSpentPerItem)
xlabel("Item")
ylabel("Total Revenue")
title("Total Spent per Item")
grid on

% Transactions per item
transactionCounts2 = splitapply(@numel, Tclean.(itemVar), itemGroups2);

figure
bar(categorical(itemNames2), transactionCounts2)
xlabel("Item")
ylabel("Number of Transactions")
title("Transactions per Item")
grid on

% Pie chart of payment methods
figure
pie(payCounts, cellstr(payNames))
title("Payment Methods")

% Histogram of Total Spent
figure
histogram(Tclean.TotalSpent)
xlabel("Total Spent")
ylabel("Frequency")
title("Histogram of Total Spent")
grid on