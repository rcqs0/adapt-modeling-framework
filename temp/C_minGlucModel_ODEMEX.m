function dxdt = C_minGlucModel_ODEMEX(t,x,p,u,m)

I = interpolate( &u(m.u.I_t), &u(m.u.I), 12, t, 1);
Ra = interpolate( &u(m.u.Ra_t), &u(m.u.Ra), 10, t, 1);

Gtot = m.c.Gtot;
Vg = m.c.Vg;
BW = m.c.BW;
Gb = m.c.Gb;
Ib = m.c.Ib;

G = x(m.s.G);
X = x(m.s.X);
Gin = x(m.s.Gin);

p1 = p(m.p.p1);
p2 = p(m.p.p2);
p3 = p(m.p.p3);
rab = p(m.p.rab);
ra0 = p(m.p.ra0);
ra1 = p(m.p.ra1);
ra2 = p(m.p.ra2);
ra3 = p(m.p.ra3);
ra4 = p(m.p.ra4);
ra5 = p(m.p.ra5);
ra6 = p(m.p.ra6);
ra7 = p(m.p.ra7);
ra8 = p(m.p.ra8);

Ir = 0;
if ((I-Ib) > 0)
	Ir =  I-Ib;
else
	Ir = 0;
end;
dGdt = -(p1 + X) * G + p1 * Gb + Ra/Vg * 1e9/18.0182;
dXdt = -p2 * X + p3/6.94 * Ir;
Ra_g = Ra * BW / 1000;
SI = p3/p2;

dxdt(1) = dGdt;
dxdt(2) = dXdt;
dxdt(3) = Ra_g;

dxdt = dxdt(:);