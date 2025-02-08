//This file contains the package for MIPS lite simulator
//**************************************** MIPS LITE SIMULATOR *************************************** 

`ifndef MIPS_LITE
`define MIPS_LITE

package Types;
parameter IMMEDIATE_SIZE=16;
parameter OPCODE =6;
parameter REG_NUM= 32;
parameter DATA = 32;
parameter ADD_WIDTH=32;
localparam REG_WIDTH = $clog2(REG_NUM);
localparam MEM_DEPTH = 4096;
localparam  MEM_WIDTH=8;
localparam INSTRUCTION_WIDTH=32;
localparam BPI= INSTRUCTION_WIDTH/MEM_WIDTH;

longint Instruction_Count;
int Arithmetic_Instr_Count;
int Logical_Instr_Count;
int Mem_Instr_Count;
int Branch_Instr_Count;

int Instruction_Count_Decr;
int Arithmetic_Instr_Count_Decr;
int Logical_Instr_Count_Decr;
int Mem_Instr_Count_Decr;
int Branch_Instr_Count_Decr;

int clockCount;
int stalls;
int Data_Hazards;
int finalClockCount;

logic [2:0] waitCount;

typedef union packed{
  
  struct packed {
    logic [REG_WIDTH-1:0] rs;
    logic [REG_WIDTH-1:0] rt;
    logic [REG_WIDTH-1:0] rd;
    logic[10:0] invalid;
  }R;
  
  struct packed{
    logic [REG_WIDTH-1:0] rs;
    logic [REG_WIDTH-1:0] rt;
    logic [IMMEDIATE_SIZE-1:0] imm;
  }I;

}instruction;

typedef struct packed{
  logic[OPCODE-1:0] opcode;
  instruction Type;
}Instruct;


typedef struct packed{
  logic memWriteEnable;
  logic regWrite;
  logic writeBack;
  logic wbMux;
  logic rs2;
  logic jump;
  logic [2:0] aluop;
}Control;

//pipeline buffers
struct packed{
  logic [ADD_WIDTH-1:0] pc;
  Instruct instruction;  
}Fetch_Buffer;

struct packed{
  Instruct instruction;
  logic [DATA-1:0] readData1;
  logic [DATA-1:0] readData2;
  logic [DATA-1:0] immOut;
  logic [ADD_WIDTH-1:0] pc;
  Control cntrl;
  logic haltSignal;
  logic [REG_WIDTH-1:0] rd;
}Decode_Buffer;

struct packed {
  Instruct instruction;
  logic [DATA-1:0] aluOut;
  logic [ADD_WIDTH-1:0] branchAddress;
  logic [DATA-1:0] writeData;
  Control cntrl;
  logic branchTaken;
  logic haltSignal;
  logic [REG_WIDTH-1:0] rd;
}Execution_Buffer;

struct packed{
  Instruct instruction;
  logic [DATA-1:0] memDataOut;
  logic [DATA-1:0] writeBackData;
  Control cntrl;
  logic branchTaken;
  logic haltSignal;
  logic [REG_WIDTH-1:0] rd;

}Memory_Buffer;

struct packed{
Control cntrl;
}Cntrl_Buffer[2:0];

struct packed{
  logic [REG_WIDTH-1:0] rs1;
  logic [REG_WIDTH-1:0] rs2;
  logic [REG_WIDTH-1:0] rd;
 
} Read__Buffer[2:0];



function Total_Instruction_Count();
  Instruction_Count = Instruction_Count + 1;
endfunction

function Arithmetic_Instruction_Count();
  Arithmetic_Instr_Count = Arithmetic_Instr_Count + 1;
endfunction
function Logical_Instruction_Count();
  Logical_Instr_Count = Logical_Instr_Count + 1;
endfunction

function Mem_Instruction_Count();
  Mem_Instr_Count = Mem_Instr_Count + 1;
endfunction

function Branch_Instruction_Count();
  Branch_Instr_Count = Branch_Instr_Count + 1;
endfunction


function Total_Instruction_Count_Decr();
  Instruction_Count_Decr = Instruction_Count_Decr + 1;
endfunction

function Arithmetic_Instruction_Count_Decr();
  Arithmetic_Instr_Count_Decr = Arithmetic_Instr_Count_Decr + 1;
endfunction
function Logical_Instruction_Count_Decr();
  Logical_Instr_Count_Decr = Logical_Instr_Count_Decr + 1;
endfunction

function Mem_Instruction_Count_Decr();
  Mem_Instr_Count_Decr = Mem_Instr_Count_Decr + 1;
endfunction

function Branch_Instruction_Count_Decr();
  Branch_Instr_Count_Decr = Branch_Instr_Count_Decr + 1;
endfunction

task hazardDetection(Read__Buffer,rd1,rd2);
  
endtask





function waitcount();
	waitCount = waitCount + 1'b1;
endfunction

function stallscount();
	stalls = stalls + 1;
endfunction

function Data_Hazardscount();
	Data_Hazards = Data_Hazards + 1;
endfunction

endpackage
`endif
