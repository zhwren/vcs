/*******************************************************************************
**                                  _ooOoo_                                   **
**                                 o8888888o                                  **
**                                 88" . "88                                  **
**                                 (| -_- |)                                  **
**                                  O\ = /O                                   **
**                              ____/`---'\____                               **
**                            .   ' \\| |// `.                                **
**                             / \\||| : |||// \                              **
**                           / _||||| -:- |||||- \                            **
**                             | | \\\ - /// | |                              **
**                           | \_| ''\---/'' | |                              **
**                            \ .-\__ `-` ___/-. /                            **
**                         ___`. .' /--.--\ `. . __                           **
**                      ."" '< `.____<|>_/___.' >'"".                         **
**                     | | : `- \`.;` _ /`;.`/ - ` : | |                      **
**                       \ \ `-. \_ __\ /__ _/ .-` / /                        **
**               ======`-.____`-.___\_____/___.-`____.-'======                **
**                                  `=---='                                   **
**                                                                            **
**               .............................................                **
**                      Buddha bless me, No bug forever                       **
**                                                                            **
********************************************************************************
** Author           :     ZhuHaiWen                                           **
** Email            :     zhuhw@ihep.ac.cn/zhwren0211@whu.edu.cn              **
** Last modified    :     2022-07-02 20:59:11                                 **
** Filename         :     env.sv
** Phone Number     :     18625272373                                         **
** Discription      :                                                         **
*******************************************************************************/
`ifndef __ENV_SV__
`define __ENV_SV__

`include "driver.sv"
`include "rm.sv"

class env extends uvm_component;
    driver drv;
    rm     rrm;

    `uvm_component_utils_begin(env)
    `uvm_component_utils_end

    extern function new(string name="env", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 21:01:00                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function env::new(string name="env", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 21:01:32                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function void env::build_phase(uvm_phase phase);
    drv = driver::type_id::create("drv", this);
    rrm = rm::type_id::create("rm", this);
endfunction

`endif
