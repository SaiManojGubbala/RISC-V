# RISC-V-RV32I
Different methods of implementation of RISC-V ( Reduced Instruction Set Computing ) Integer Edition with all the instructions along with the Control Status Register with different methods of modelling and pipeline

## **Designing an ALU in GATE LEVEL MODELLING for R-Type Instructions in RISC-V**

## The RTL for some circuitry is generated using Yosys software and is given below

### **RTL Schematic of RISC-V ALU (Gate Level Modelling) **
![Arithemetic Logic Unit](https://github.com/SaiManojGubbala/RISC-V/blob/main/alu.png)


### **RTL Schematic of RISC-V Instruction Decoder (Gate Level Modelling) **
![Instruction Decoder](https://github.com/SaiManojGubbala/RISC-V/blob/main/instruction_decoder.png)


### **RTL Schematic of RISC-V Branch Circuitry (Gate Level Modelling) **
![Branch](https://github.com/SaiManojGubbala/RISC-V/blob/main/branch.png)


### **RTL Schematic of RISC-V Sign Extension (Gate Level Modelling) **
![Sign Extension](https://github.com/SaiManojGubbala/RISC-V/blob/main/sign_extend.png)


### **RTL Schematic of RISC-V PC ADD 4 (Gate Level Modelling) **
![ADD4](https://github.com/SaiManojGubbala/RISC-V/blob/main/pc_add4.png)


### **RTL Schematic of RISC-V PC ADD Imm(Gate Level Modelling) **
![ADDIMM](https://github.com/SaiManojGubbala/RISC-V/blob/main/pc_addimm.png)




The **Arithmetic Logic Unit (ALU)** is a crucial component of a processor, responsible for executing arithmetic, logical, and shift operations. This ALU is designed to support **R-Type Instructions** in **RISC-V**, handling **10 different operations**.

---

## **1. Operations Supported**
The ALU performs three categories of operations:

### **1.1 Arithmetic Operations**
| Instruction | Operation                          | Description                     |
|------------|----------------------------------|---------------------------------|
| ADD        | `A + B`                          | Addition                        |
| SUB        | `A - B`                          | Subtraction                     |
| SLT        | `(A < B) ? 1 : 0`                | Set Less Than (Signed)          |
| SLTU       | `(unsigned(A) < unsigned(B)) ? 1 : 0` | Set Less Than Unsigned |

### **1.2 Logical Operations**
| Instruction | Operation  | Description          |
|------------|-----------|----------------------|
| XOR        | `A ^ B`   | Bitwise XOR         |
| OR         | `A | B`   | Bitwise OR          |
| AND        | `A & B`   | Bitwise AND         |

### **1.3 Shift Operations**
| Instruction | Operation  | Description                     |
|------------|-----------|---------------------------------|
| SLL        | `A << B`  | Shift Left Logical              |
| SRL        | `A >> B`  | Shift Right Logical             |
| SRA        | `A >>> B` | Shift Right Arithmetic          |

---

## **2. Instruction Encoding and Funct3 Values**
Each **R-Type instruction** is uniquely identified by the **funct3** field in the instruction format.

| Instruction | Funct3 |
|------------|--------|
| ADD        | 000    |
| SUB        | 000    |
| SLL        | 001    |
| SLT        | 010    |
| SLTU       | 011    |
| XOR        | 100    |
| SRL        | 101    |
| SRA        | 101    |
| OR         | 110    |
| AND        | 111    |

---

## **3. Differentiation of Similar Funct3 Values**
Some instructions share the same **funct3** encoding. The difference is determined by **bit 5 of funct7**.

| Instruction Pair | Funct3 | funct7[5] | Operation |
|-----------------|--------|-----------|-----------|
| ADD vs SUB     | 000    | 0 → ADD   | 1 → SUB   |
| SRL vs SRA     | 101    | 0 → SRL   | 1 → SRA   |

- If **funct7[5] = 0**, the instruction is **ADD** or **SRL**.
- If **funct7[5] = 1**, the instruction is **SUB** or **SRA**.

---

## **4. Special Case: SUB in I-Type Instructions**
- **SUB does not exist in I-Type instructions.**
- In I-Type instructions, the `funct7[5]` bit is part of the **immediate field**, not `funct7`.
- This means `funct7[5] = 1` does **not** indicate a subtraction.

---

## **5. ALU Design Considerations**
To implement these operations, the ALU should have:

1. **Arithmetic Unit**: Handles **ADD, SUB, SLT, SLTU** operations.
2. **Logical Unit**: Performs **XOR, OR, AND**.
3. **Shifter Unit**: Executes **SLL, SRL, SRA**.
4. **Multiplexers**: Select between different results based on `funct3` and `funct7[5]`.

---

## **6. ALU Operation Selection Logic**
The ALU control logic is designed based on **funct3** and **funct7[5]**.

### **6.1 ALU Control Signal Mapping**
| Funct3 | Funct7[5] | ALU Operation |
|--------|----------|--------------|
| 000    | 0        | ADD          |
| 000    | 1        | SUB          |
| 001    | X        | SLL          |
| 010    | X        | SLT          |
| 011    | X        | SLTU         |
| 100    | X        | XOR          |
| 101    | 0        | SRL          |
| 101    | 1        | SRA          |
| 110    | X        | OR           |
| 111    | X        | AND          |

- `"X"` means the value of `funct7[5]` does not affect the instruction.

### **6.2 ALU Logic Implementation**
- **ADD/SUB**: `Result = A + (funct7[5] ? ~B + 1 : B);`
- **SLT/SLTU**: `Result = (signed(A) < signed(B)) ? 1 : 0;`
- **XOR, OR, AND**: Direct bitwise operations.
- **SLL/SRL/SRA**: Use the shift unit with different logic.

---

## **7. Implementation in Hardware**
### **7.1 ALU Block Diagram**
The ALU design consists of:
- **Multiplexers** to choose between operations.
- **Arithmetic Logic Circuits** for addition, subtraction, and comparisons.
- **Logical Circuits** for bitwise operations.
- **Shift Circuits** for shifting operations.

### **7.2 Hardware Modules**
Each operation is implemented using basic logic gates:
- **Addition/Subtraction**: Full adder circuits.
- **Bitwise Logic Operations**: AND, OR, XOR gates.
- **Shift Operations**: Barrel shifters for SLL, SRL, and SRA.

---

## **8. Verilog Implementation**
A sample Verilog implementation of the ALU based on the above logic would involve:
- **Case statements** to select operations.
- **Bitwise operations** for logical instructions.
- **Shift operations** using shift operators.
- **Multiplexers** for ADD/SUB and SRL/SRA differentiation.

---

## **9. Testing the ALU**
The ALU should be tested with:
1. **All possible funct3 values**.
2. **Different values of funct7[5]** to differentiate ADD/SUB and SRL/SRA.
3. **Signed and unsigned comparisons** for SLT and SLTU.
4. **Shifting edge cases** (e.g., shifting by 0 or 31 bits).
5. **Logical operations with all 1s and 0s to check correctness**.

A Verilog testbench can be created to verify each instruction using **assertions** and **test vectors**.

---

## **10. Conclusion**
- This ALU efficiently supports all **R-Type Instructions** in **RISC-V**.
- Uses **funct3** and **funct7[5]** to differentiate between similar instructions.
- Implements **arithmetic, logical, and shift operations** using minimal hardware.
- Can be integrated into a **RISC-V processor pipeline** to execute ALU operations efficiently.

---

## **RTL Schematic of RISC-V ALU (Gate Level Modelling) **
![Arithemetic Logic Unit](https://github.com/SaiManojGubbala/RISC-V-RV32I/blob/main/Screenshot%20from%202025-03-11%2019-19-53.png)



# Implementing a 32 Bit Risc-V Cpu in Verilog 
## This is a project on implementing a 32Bit Risc-V Processor in Verilog which is following official <span style="color:Cyan">RV32I ISA (Instruction Set Architecture)</span>
### This Processor has a 5 stage Pipeline along with the Hazard Unit 
## Description :
    - Instruction Set :
        This is a 32 Bit Risc-V Architecture so each Instruction is of 32 Bits and
        it can execute the following instruction types
            R-Type - ADD SUB SLL SLT SLTU XOR SRL SRA OR AND
            I-Type - ADDI SLLI SLTI SLTIU XORI SRLI SRAI ORI ANDI
            B-Type - BEQ BNE BLTU BGTU
            J-Type - JAL 
            L-Type - LW 
            S-Type - SW
    
    - Pipelining :
        This Processor involves a 5 stage Pipeline Architecture The pipeline steps involving :
            IF   - Instruction Fetch
            ID   - Instruction Decode
            IEx  - Instruction Execute
            IMem - Memory  Access
            IW   - Write Back

    - Hazard Detection :
        As Pipeline comes with Hazards It has a Hazard Unit which can detect some hazards and also 
    these hazards can be prevented using Forwarding , Stalling and Branch Prediction etc.. This 
    processor has implemented Forwarding and Stalling for the hazards which are implemented here

    - Verilog Implementation : 
      This processor uses DataPath Controller type implementation in Verilog   
---
### Processor Architecture :
![Screenshot 2024-06-22 233054](https://github.com/SaiManojGubbala/RISC-V/assets/171187843/a12e9001-813d-4f0d-ad2c-8a9f485b867e)
---
## Methodology :
### <span style="color:Cyan">ALU</span> ( Arthemetic Logic Unit ) :
##### All the Arthemetic Shift and Logic Operations are done in the R-Type Instruction set So designing ALU for R-Type and using this for Other Type Instructions 
##### Let there be two 32 bit inputs and one 32 bit outputs
| funct7[5] | funct3 | Operation | Implementation |
| --- | --- | --- | --- |
| 0 | 000 | ADD | Output = Input1 + Input2 | 
| 1 | 000 | SUB | Output = Input1 - Input2 | 
| 0 | 001 | SLL | Output = Input1 << Input2 | 
| 0 | 010 | SLT | Output = bool(Input1 < Input2) | 
| 0 | 011 | SLTU | Output = bool(sign(Input1) < sign(Input2)) | 
| 0 | 100 | XOR | Output = Input1 ^ Input2 | 
| 0 | 101 | SRL | Output = Input1 >> Input2 | 
| 0 | 101 | SRA | Output = Input1 >>> Input2 | 
| 1 | 110 | OR | Output = Input1 I Input2 | 
| 0 | 111 | AND | Output = Input1 & Input2 | 
### <span style="color:Cyan">ISA</span> ( Instruction Set ) :
    Instruction is 32 Bit Long it has the following sections :
       Opcode : Instruction[6:0]
       rd     : Instruction[11:7]
       funct3 : Instruction[14:12]
       rs1    : Instruction[19:15]
       rs2    : Instruction[24:20]
       funct7 : Instruction[31:25]
### <span style="color:Cyan">Immediate Fields</span> ( Sign Extenstion) : 
##### But some Instructions don't use this fields instead they have Immediate fields and is calculated as
| Instruction[31:25] | Instruction[24:20] | Instruction[19:15] | Instruction[14:12] | Instruction[11:7] | Instruction[6:0] | Type |
| --- | --- | --- | --- | --- | --- | --- |
| funct7 | rs2 | rs1 | funct3 | rd | Opcode | R-Type |
| imm[11:5] | imm[4:0] | rs1 | funct3 | rd | Opcode | I-Type |
| imm[11:5] | rs2 | rs1 | funct3 | imm[4:0] | Opcode | S-Type |
| imm[12] imm[10:5] | rs2 | rs1 | funct3 | imm[4:1] imm[11] | Opcode | B-Type |
| imm[11:5] | imm[4:0] | rs1 | funct3 | rd | Opcode | L-Type | 
| imm[20] imm[10:5] | imm[4:1] imm[11] | imm[19:15] | imm[14:12] | rd | Opcode | J-Type |
### <span style="color:Cyan">Opcode</span> :
     Opcode is the value which tells what type of Instruction that is getting executed 
       R - Type : 0110011
       I - Type : 0010011
       B - Type : 1100011
       J - Type : 1101111
       L - Type : 0000011
       S - Type : 0100011
#### Instruction Execution :
    R Type Instructions get executed as per the ALU
    I Type follows the same as ALU but I Type Doesnt have SUB Operation
    B Type Instruction uses SUB operation to compare values
    S and L Operation uses ADD operation to calculate the Memory Address
    J type uses ADD operation to calculate Address of Register File
##### Control Signal :
    Control Signal = {funct7,funct3}
##### R Type Instruction Explained :
    ADD : 
        RegFile[rd] = RegFile[rs2]+RegFile[rs1];
    SUB :                  
        RegFile[rd] = RegFile[rs1]-RegFile[rs2];
    SLL :                     
        RegFile[rd] = RegFile[rs1] << (RegFile[rs2] & 0x1F);
    SLT :       
        RegFile[rd] = ( (signed long)RegFile[rs1] < (signed long)RegFile[rs2] ) ? 1 : 0;
    SLTU :       
        RegFile[rd] = (RegFile[rs1]<RegFile[rs2]) ? 1 : 0;
    XOR :       
        RegFile[rd] = RegFile[rs1] ^ RegFile[rs2];
    SRL :
        RegFile[rd] = RegFile[rs1] >> (RegFile[rs2] & 0x1F);
    SRA :
        RegFile[rd]=RegFile[rs1]; 
        shamt=(RegFile[rs2] & 0x1F); 
        Temp=RegFile[rs1]&0x80000000;
        while (shamt>0)
        { RegFile[rd]=(RegFile[rd]>>1)|Temp; 
          shamt--; // This is for sign shifting
        }
    OR :                 
        RegFile[rd] = RegFile[rs1] | RegFile[rs2];
    AND :
        RegFile[rd] = RegFile[rs1] & RegFile[rs2];
##### I Type Instruction Explained :
    ADDI : 
        RegFile[rd] = Immediate_Value+RegFile[rs1];
    SLLI :                     
        RegFile[rd] = RegFile[rs1] << (Immediate_Value & 0x1F);
    SLTI :       
        RegFile[rd] = ( (signed long)RegFile[rs1] < (signed long)Immediate_Value ) ? 1 : 0;
    SLTIU :       
        RegFile[rd] = (RegFile[rs1]<Immediate_Value) ? 1 : 0;
    XORI :       
        RegFile[rd] = RegFile[rs1] ^ Immediate_Value;
    SRLI :
        RegFile[rd] = RegFile[rs1] >> (Immediate_Value & 0x1F);
    SRAI :
        RegFile[rd]=RegFile[rs1]; 
        shamt=(Immediate_Value & 0x1F); 
        Temp=RegFile[rs1]&0x80000000;
        while (shamt>0)
        { RegFile[rd]=(RegFile[rd]>>1)|Temp; 
          shamt--; // This is for sign shifting
        }
    ORI :                 
        RegFile[rd] = RegFile[rs1] | Immediate_value;
    ANDI :
        RegFile[rd] = RegFile[rs1] & Immediate_Value;
##### B Type Instruction Explained :
| funct3 | 000 | 001 | 110 | 111 |
| --- | --- | --- | --- | --- |
| Branch | BEQ | BNE | BLTU | BGTU |
    BEQ :
        if(RegFile[rs1] == RegFile[rs2])
        {
         PC = Immediate_Value + PC ;
        }
    BNE :
        if(RegFile[rs1] != RegFile[rs2])
        {
         PC = Immediate_Value + PC ;
        }
    BLTU :
        if(RegFile[rs1] < RegFile[rs2])
        {
         PC = Immediate_Value + PC ;
        }
    BGTU :
        if(RegFile[rs1] >= RegFile[rs2])
        {
         PC = Immediate_Value + PC ;
        }  
##### S Type Instruction Explained :
    SW :
        Data_Memory[(Immediate_Value + RegFile[rs1])] = RegFile[rs2] ;       
##### J Type Instruction Explained :
    JAL :
        RegFile[rd] = PC + 0x4;
        PC = Immediate_Value + PC ;
##### L Type Instruction Explained :
    LW  :
        RegFile[rd] = Data_Memory[Immediate_Value + RegFile[rs1]] ;
---
### Understanding Memories :
     Register File :
       These are the registers that are present inside the cpu and some are used for specific operations and 
       some of them are temporary registers which are used for data storage
       RV32 has 32 Registers each 32 Bit Wide
       As there are 32 Regiters 2^5 so 5 Bits Address is required
     Instruction Memory :
       This is the memory that user writes in it each cell of this memory is 8 Bit Wide and
       it contains the Instructions in order of which it gets executed
       As Program Counter holds the Address of Instruction Memory and is 32 Bit wide so maximum size of Instruction Memory can be 2^32...

       And Output Instruction is 32 Bit Wide Considering it LITTLE ENDIAN CPU
       Output is :
       {Ins_Mem[PC+3],Ins_Mem[PC+2],Ins_Mem[Pc+1],Ins_Mem[PC]}
    Data Memory :
       This can be considered as RAM it stores the data 
       data can be read or written from Data Memory 
       ALU Result Acts as its address which is 32 Bit so maximum size of Data Memory is 2^32  
#### Program Counter :
    Program Counter is the register which has the address of the instruction that is being executed 
    Its value increments once its instruction gets executed 
    The PC Value should change depending on JUMP and Branch Type Instructions 
![Program Counter](https://github.com/SaiManojGubbala/RISC-V/assets/171187843/1aa7165d-3760-48fb-a004-f5fe94054f01)

---
#### Data Forwarding : 
    Forwarding is a technique that is used to avoid hazards in pipelined processors
    These occur when instruction close to each other use the same data
    If Both the registers in the Excution and memory cycle are same i.e rs1 or rs2 == rd
    Then get the value directly from ALU Result These methods are shown in the processor Architecture
#### Stalling :
    Let us consider we need to do a read operation and the cpu is doing write operation 
    But CPU doesn't execute read and write at the same time 
    So, We Stop the pipeline making it repeat the instruction in the next cycle until the issue gets cleared
---
#### RTL BLOCKS : 
__Generated___ __using__ __Xilinx__ __Vivado__
##### Top Block :
![TOP](https://github.com/SaiManojGubbala/RISC-V/assets/171187843/d5c6bf50-692d-4d99-8aaa-d025e4331e4f)
##### RISC Block :
![RISC](https://github.com/SaiManojGubbala/RISC-V/assets/171187843/46369895-763e-495c-8405-3899d1ad42bc)

## References :
- #### Research Papers : 
   - [RISC-V Publication](https://ijrpr.com/uploads/V5ISSUE4/IJRPR24834.pdf)
- #### Video Tutorials :
   - [RISC - V Computer Architecture](https://youtube.com/playlist?list=PLoVsjlwzzlUTSkgVdPrGLIs92cqCAb_9u&si=aw2Cb8XgBB6rmzVV)
   - [Computer Architecture](https://youtube.com/playlist?list=PL-Mfq5QS-s8iUJpNzCOtQKRfpswCrPbiW&si=iuacXpKniFnFiFy3)
## Tools and Softwares used :
    - Icarus Verilog 
    - GtkWave
    - Visual Studio Code
    - Xilinx Vivado
  
---
