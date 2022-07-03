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
** Last modified    :     2022-07-02 20:31:36                                 **
** Filename         :     rm.sv
** Phone Number     :     18625272373                                         **
** Discription      :                                                         **
*******************************************************************************/
`ifndef __DRIVER_SV__
`define __DRIVER_SV__

`include "xaction.sv"
`include "connector.sv"

class rm extends uvm_component;
    uvm_blocking_get_peek_port #(xaction) inport;

    `uvm_component_utils_begin(rm)
    `uvm_component_utils_end

    extern function new(string name="rm", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:33:00                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function rm::new(string name="rm", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:34:15                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function void rm::build_phase(uvm_phase phase);
    string dest = "rm";
    connector#(xaction)::regist_inport("test", inport, dest);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:34:31                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
task rm::main_phase(uvm_phase phase);
    xaction a;

    `uvm_info(get_name(), $sformatf("main phase start!"), UVM_LOW);
    while (1) begin
        inport.get(a);
        `uvm_info(get_name(), $sformatf("    get input data : %b, %0d", a.vld, a.data), UVM_LOW);
    end

    `uvm_info(get_name(), $sformatf("main phase finish!"), UVM_LOW);
endtask

`endif
