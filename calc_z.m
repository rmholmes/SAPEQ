% Calculate z_rho and z_w from a ROMS history or average file (fname)
% and save back into that file.

addpath(genpath('~/software/matlab-utilities/'));
startup;

dozvzu = 0;

% Create variable:
ncid = netcdf.open(fname,'NC_WRITE');
% $$$ try
% $$$     id = netcdf.inqVarID(ncid,'z_rho');
% $$$     not_there = 0;
% $$$ catch
    not_there = 1;
% $$$ end
%If variable not there, add it:
if (not_there)
    xid = netcdf.inqDimID(ncid,'xi_rho');yid = netcdf.inqDimID(ncid,'eta_rho');zrid = netcdf.inqDimID(ncid,'s_rho');zwid = netcdf.inqDimID(ncid,'s_w');tid = netcdf.inqDimID(ncid,'ocean_time');
    netcdf.reDef(ncid);

    zrhoID = netcdf.inqVarID(ncid,'z_rho');
% $$$     zrhoID = netcdf.defVar(ncid,'z_rho','NC_DOUBLE',[xid yid zrid tid]);
    %    netcdf.defVarDeflate(ncid,zrhoID,true,true,5);
    netcdf.putAtt(ncid,zrhoID,'long_name','Height at rho-points');
    netcdf.putAtt(ncid,zrhoID,'units','m');

    zwID = netcdf.defVar(ncid,'z_w','NC_DOUBLE',[xid yid zwid tid]);
    %    netcdf.defVarDeflate(ncid,zwID,true,true,5);
    netcdf.putAtt(ncid,zwID,'long_name','Height at w-points');
    netcdf.putAtt(ncid,zwID,'units','m');

    netcdf.endDef(ncid);
else
    zrhoID = netcdf.inqVarID(ncid,'z_rho');
    zwID = netcdf.inqVarID(ncid,'z_w');
end

if (dozvzu == 1)
try
    id = netcdf.inqVarID(ncid,'z_u');
    not_there = 0;
catch
    not_there = 1;
end
%If variable not there, add it:
if (not_there)
    xvid = netcdf.inqDimID(ncid,'xi_v');yvid = netcdf.inqDimID(ncid,'eta_v');
    xuid = netcdf.inqDimID(ncid,'xi_u');yuid = netcdf.inqDimID(ncid,'eta_u');
    zrid = netcdf.inqDimID(ncid,'s_rho');tid = netcdf.inqDimID(ncid,'ocean_time');
    netcdf.reDef(ncid);

    zvID = netcdf.defVar(ncid,'z_v','NC_DOUBLE',[xvid yvid zrid tid]);
    netcdf.defVarDeflate(ncid,zvID,true,true,5);
    netcdf.putAtt(ncid,zvID,'long_name','Height at v-points');
    netcdf.putAtt(ncid,zvID,'units','m');

    zuID = netcdf.defVar(ncid,'z_u','NC_DOUBLE',[xuid yuid zrid tid]);
    netcdf.defVarDeflate(ncid,zuID,true,true,5);
    netcdf.putAtt(ncid,zuID,'long_name','Height at u-points');
    netcdf.putAtt(ncid,zuID,'units','m');

    netcdf.endDef(ncid);
else
    zuID = netcdf.inqVarID(ncid,'z_u');
    zvID = netcdf.inqVarID(ncid,'z_v');
end

end

tL = length(ncread(fname,'ocean_time'));
h = ncread(fname,'h');
[xL,yL] = size(h);
zL = length(ncread(fname,'s_rho'));

for ti=1:tL
    ['Doing time ' num2str(ti) ' of ' num2str(tL)]
    zeta = ncread(fname,'zeta',[1 1 ti],[xL yL 1]);
    [z_rho,z_w] = ROMS_depths(fname,zeta,h);

    netcdf.putVar(ncid,zrhoID,[0 0 0 ti-1],[xL yL zL 1],z_rho);
    netcdf.putVar(ncid,zwID,[0 0 0 ti-1],[xL yL zL+1 1],z_w);
    
    if (dozvzu == 1)
        z_v = (z_rho(:,1:(end-1),:)+z_rho(:,2:end,:))/2;
        z_u = (z_rho(1:(end-1),:,:)+z_rho(2:end,:,:))/2;
        netcdf.putVar(ncid,zvID,[0 0 0 ti-1],[xL yL-1 zL 1],z_v);
        netcdf.putVar(ncid,zuID,[0 0 0 ti-1],[xL-1 yL zL 1],z_u);
    end
end

netcdf.close(ncid);


