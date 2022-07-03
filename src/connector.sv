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
** Email            :     zhwren0211@whu.edu.cn                               **
** Last modified    :     2022-07-02 20:36:31                                 **
** Filename         :     connector.sv
** Phone Number     :     15756230211                                         **
** Discription      :                                                         **
*******************************************************************************/
`ifndef __CONNECTOR_SV__
`define __CONNECTOR_SV__

class connector #(type T=uvm_sequence_item) extends uvm_object;
    static uvm_blocking_get_peek_port #(T) inport[string][string][$];
    static uvm_analysis_port          #(T) outport[string][$];
    static uvm_tlm_analysis_fifo      #(T) fifo[string][string][$];

    extern static function void regist_outport(string name, ref uvm_analysis_port #(T) port);
    extern static function void regist_inport(string name, ref uvm_blocking_get_peek_port #(T) port, string dest="null");
endclass

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:41:40                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function void connector::regist_inport(string name, ref uvm_blocking_get_peek_port #(T) port, string dest="null");
    int len = 0;
    uvm_tlm_analysis_fifo #(T) tfifo;

    if (inport.exists(name) && inport[name].exists(dest)) begin
        len = inport[name][dest].size();
    end

    port = new($sformatf("connector_inport_%s_%s_%0d", name, dest, len), null);
    tfifo = new($sformatf("connector_fifo_%s_%s_%0d", name, dest, len));
    inport[name][dest].push_back(port);
    fifo[name][dest].push_back(tfifo);
    port.connect(tfifo.blocking_get_peek_export);

    if (outport.exists(name) && outport[name].size() > len) begin
        outport[name][len].connect(tfifo.analysis_export);
    end
    `uvm_info("connector", $sformatf("regist inport"), UVM_LOW);
endfunction

/*******************************************************************************
** Author      : zhuhw                                                        **
** Modify Time : 2022-07-02 20:54:51                                          **
** Description :                                                              **
** Modify Info : create                                                       **
*******************************************************************************/
function void connector::regist_outport(string name, ref uvm_analysis_port #(T) port);
    int len = 0;
    string dest;

    if (outport.exists(name)) begin
        len = outport[name].size();
    end

    port = new($sformatf("outport_%s_%0d", name, len), null);
    outport[name].push_back(port);

    `uvm_info("connector", $sformatf("regist outport"), UVM_LOW);
    if (!inport.exists(name) || !inport[name].first(dest)) return;
    do begin
        if (inport[name][dest].size() > len) begin
            port.connect(fifo[name][dest][len].analysis_export);
            `uvm_info("connector", $sformatf("outport connect"), UVM_LOW);
        end
    end while (inport[name].next(dest));
endfunction

`endif
