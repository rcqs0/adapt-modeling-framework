function u = C_minGlucModel_INPUTS(t,uv,m)

u(1) = interp1(uv(m.u.I_t), uv(m.u.I), t, 'Linear', 'extrap');
u(2) = interp1(uv(m.u.Ra_t), uv(m.u.Ra), t, 'Linear', 'extrap');
