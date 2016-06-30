function [status, results] = mrtrix_tensor2vector (in_file, out_file, ...
                                fa_file,  verbose, mrtrixVersion)

%
% Calculate an eigenvector map.
%
% Parameters
% ----------
% in_file: The name of a dt file in .mif format
% out_file: The name of the resulting eigenvector map file in .mif format
% fa_file: optional. The name of an mrtrix format fa map file (per default,
% the eigenvector map will not be weighted by the FA).
%
% Returns
% -------
% status: whether (0) or not (1) the operation succeeded
% results: the results of the operation in the terminal
%
% Notes
% -----
% http://www.brain.org.au/software/mrtrix/tractography/preprocess.html
% 
% Edited GLU 06.2016:
%        1.- Include mrTrix version


if mrtrixVersion == 2
    func1Name = 'tensor2FA';
    func2Name = 'mrmult';
end
if mrtrixVersion == 3
    func1Name = 'tensor2metric -vector';
    func2Name = 'mrcalc -mult';
end


if notDefined('verbose')
    verbose = true;
end

if notDefined('bkgrnd')
    bkgrnd = false;
end

if notDefined('fa_file')
    cmd_str = sprintf('%s %s %s', func1Name, in_file,  out_file);
else
    cmd_str = sprintf('%s %s - | %s - %s %s', func1Name, in_file, fa_file, ...
                     func2Name, out_file);
end

% Send it to mrtrix:
[status,results] = mrtrix_cmd(cmd_str, bkgrnd, verbose);

