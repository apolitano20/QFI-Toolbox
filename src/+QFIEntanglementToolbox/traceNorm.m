%%  TRACENORM  Computes the trace norm of an operator
%   This function has one required argument:
%     inputOp: an operator
%
%   normVal = traceNorm(inputOp) is the trace norm of inputOp.
%
%   URL: http://www.qetlab.com/TraceNorm
 
%   requires: kpNorm.m (MISSING external dependency, expected from QETLAB)
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function normVal = traceNorm(inputOp)
 
% The kpNorm function is expected to be available from QETLAB.
% If QETLAB is not installed or kpNorm.m is not in the path, this will error.
normVal = kpNorm(inputOp,min(size(inputOp)),1);
end
