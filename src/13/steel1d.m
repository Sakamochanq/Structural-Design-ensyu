function seg=steel1d(eps,fy,Es)
%eps: ‚Ğ‚¸‚İ
%seg: ‰—Í(N/mm2)
%fy:  ~•š‹­“x(N/mm2)
%Es:  ’e«ŒW”(N/mm2)

% ~•š‚Ğ‚¸‚İ
epsy = fy/Es;

if eps > epsy
    % ˆø’£‘¤‚Å~•š
    seg = fy;

elseif eps < -epsy
    %ˆ³k‘¤‚Å~•š
    seg = -fy;

else
    % ’e«ˆæ
    seg = Es*eps;

end

