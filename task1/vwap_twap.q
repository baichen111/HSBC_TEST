// functions to calculate VWAP and TWAP given time range and a list of symbols
-1"USAGE: eg vwap[08:00;09:00;`CSCO`DELL`AAPL]\n\ntwap[08:00;09:00;`CSCO`DELL`AAPL] ";


//load csv trades table
trades:update `g#sym from `time xasc select from ("PSSFI";enlist",") 0: `:trades.csv ;

// VWAP calculation start : start time; end: end time; s: symbol list
vwap:{[start;end;s] 
    select size wavg price by sym from trades where time within(start;end),sym in s
 }

twap:{[start;end;s]
    select (next[time] - time) wavg price by sym from trades where time within(start;end),sym in s
 }