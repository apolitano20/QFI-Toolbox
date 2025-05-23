%%  OPT_ARGS    Handles optional input arguments for functions
%   This function has one required argument: DEF_ARGS, and an arbitrary
%   number of additional optional arguments
%
%   VARARGOUT = opt_args(DEF_ARGS,EXTRA_ARG1,EXTRA_ARG2,...) provides the
%   values EXTRA_ARG1, EXTRA_ARG2, ..., with the understanding that if a
%   particular EXTRA_ARGn is not provided as input, then DEF_ARGS(n) is
%   returned in its place. This is a helper function that is only used to
%   clean up and simplify code within other functions.
%
%   URL: http://www.qetlab.com/opt_args

%   requires: nothing
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox.utils (Inspired by QETLAB)

function varargout = optArgs(defArgs,varargin)
 
% verify optional arguments
maxOptArgs = length(defArgs);
numOptArgs = length(varargin);
if numOptArgs > maxOptArgs
    ST = dbstack(1);
    error(strcat(ST.name,':TooManyArguments'),'Received %d optional arguments, but expected no more than %d.',numOptArgs,maxOptArgs);
end
 
% return argument values
varargout = defArgs;
varargout(1:numOptArgs) = varargin;
