%%  TRACENORM  Computes the trace norm of an operator
%   This function has one required argument:
%     inputOp: an operator
%
%   normVal = traceNorm(inputOp) is the trace norm of inputOp.
%
%   URL: http://www.qetlab.com/TraceNorm
 
%   requires: kpNorm.m from QETLAB (optional, numeric fallback is available)
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function normVal = traceNorm(inputOp)
 
% Prefer QETLAB's kpNorm when available.
if exist('kpNorm', 'file') == 2
    try
        normVal = kpNorm(inputOp, min(size(inputOp)), 1);
        return;
    catch kpErr
        warning('QFIEntanglementToolbox:TraceNormFallback', ...
            'kpNorm failed (%s). Falling back to SVD-based trace norm.', kpErr.message);
    end
end

% Fallback for numeric operators when QETLAB is unavailable.
if ~isnumeric(inputOp)
    error('QFIEntanglementToolbox:TraceNormMissingDependency', ...
        ['traceNorm requires kpNorm.m for non-numeric operators. ' ...
         'Install QETLAB or provide a numeric operator.']);
end

normVal = sum(svd(full(inputOp)));
end

