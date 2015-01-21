#include "../dxdt.h"



int rhs( realtype t, N_Vector y, N_Vector ydot, void *f_data ) {

	struct mData *data = ( struct mData * ) f_data;

	realtype BW , G , Gb , Gin , Gtot , I , Ib , Ir , Ra_g , SI , Vg , X , dGdt , dXdt , dxdt , p1 , p2 , p3 , ra0 , ra1 , ra3 , ra4 , ra5 , ra6 , ra7 , ra8 , rab ;

	realtype *stateVars;
	realtype *ydots;

	stateVars = NV_DATA_S(y);
	ydots = NV_DATA_S(ydot);

	
	I =interpolate( &data->u[12], &data->u[0],12,t,1);
	Ra =interpolate( &data->u[34], &data->u[24],10,t,1);
	
	Gtot =40;
	Vg =1.7;
	BW =126.6;
	Gb =5489560000;
	Ib =43.39;
	
	G =stateVars[0];
	X =stateVars[1];
	Gin =stateVars[2];
	
	p1 =data->p[0];
	p2 =data->p[1];
	p3 =data->p[2];
	rab =data->p[3];
	ra0 =data->p[4];
	ra1 =data->p[5];
	ra2 =data->p[6];
	ra3 =data->p[7];
	ra4 =data->p[8];
	ra5 =data->p[9];
	ra6 =data->p[10];
	ra7 =data->p[11];
	ra8 =data->p[12];
	
	Ir =0;
	if ((I-Ib) >0){
	Ir =I-Ib;
	} else {
	Ir =0;
	};
	dGdt = -(p1 +X) *G +p1 *Gb +Ra/Vg *1e9/18.0182;
	dXdt = -p2 *X +p3/6.94 *Ir;
	Ra_g =Ra *BW /1000;
	SI =p3/p2;
	
	ydots[0] =dGdt;
	ydots[1] =dXdt;
	ydots[2] =Ra_g;
	
	


	#ifdef NON_NEGATIVE
		return 0;
	#else
		return 0;
	#endif

};

