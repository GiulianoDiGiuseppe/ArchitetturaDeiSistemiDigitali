/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_115(char*, char *);
extern void execute_116(char*, char *);
extern void execute_15(char*, char *);
extern void execute_19(char*, char *);
extern void execute_23(char*, char *);
extern void execute_106(char*, char *);
extern void execute_107(char*, char *);
extern void execute_108(char*, char *);
extern void execute_18(char*, char *);
extern void execute_21(char*, char *);
extern void execute_22(char*, char *);
extern void execute_25(char*, char *);
extern void execute_30(char*, char *);
extern void execute_31(char*, char *);
extern void execute_105(char*, char *);
extern void execute_110(char*, char *);
extern void execute_111(char*, char *);
extern void execute_113(char*, char *);
extern void execute_114(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[21] = {(funcp)execute_115, (funcp)execute_116, (funcp)execute_15, (funcp)execute_19, (funcp)execute_23, (funcp)execute_106, (funcp)execute_107, (funcp)execute_108, (funcp)execute_18, (funcp)execute_21, (funcp)execute_22, (funcp)execute_25, (funcp)execute_30, (funcp)execute_31, (funcp)execute_105, (funcp)execute_110, (funcp)execute_111, (funcp)execute_113, (funcp)execute_114, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 21;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/Divider_On_Board_tb_behav/xsim.reloc",  (void **)funcTab, 21);
	iki_vhdl_file_variable_register(dp + 11024);
	iki_vhdl_file_variable_register(dp + 11080);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/Divider_On_Board_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/Divider_On_Board_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/Divider_On_Board_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/Divider_On_Board_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/Divider_On_Board_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
