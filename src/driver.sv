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
** Filename         :     driver.sv
** Phone Number     :     18625272373                                         **
** Discription      :                                                         **
*******************************************************************************/
`ifndef __RM_SV__
`define __RM_SV__

`include "connector.sv"
`include "xaction.sv"

class driver extends uvm_component;
    uvm_analysis_port #(xaction) outport;
    uvm_blocking_get_peek_port #(int) testinport;
    uvm_analysis_port #(int) testoutport;

    `uvm_component_utils_begin(driver)
    `uvm_component_utils_end

    extern function new(string name="driver", uvm_component parent=null);
    extern function void build_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:33:00                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function driver::new(string name="driver", uvm_component parent=null);
    super.new(name, parent);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:34:15                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function void driver::build_phase(uvm_phase phase);
    string dest = "driver";
    connector#(xaction)::regist_outport("test", outport);
    connector#(int)::regist_inport("data", testinport, dest);
    connector#(int)::regist_outport("data", testoutport);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:34:31                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
task driver::main_phase(uvm_phase phase);
    xaction a;

    `uvm_info(get_name(), $sformatf("main phase start!"), UVM_LOW);

    phase.raise_objection(this);
    repeat (10) begin
        a = new();
        a.randomize();
        outport.write(a);
        testoutport.write(a.data);
        `uvm_info(get_name(), $sformatf("send data : %b, %0d", a.vld, a.data), UVM_LOW);
        #2ns;
    end

    `uvm_info(get_name(), $sformatf("main phase finish!"), UVM_LOW);
    phase.drop_objection(this);
endtask

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-03 09:23:09                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
task driver::run_phase(uvm_phase phase);
    int a;

    `uvm_info(get_name(), $sformatf("main phase start!"), UVM_LOW);
    while (1) begin
        testinport.get(a);
        `uvm_info(get_name(), $sformatf("get input data : %0d", a), UVM_LOW);
    end

    `uvm_info(get_name(), $sformatf("main phase finish!"), UVM_LOW);

endtask

`endif
