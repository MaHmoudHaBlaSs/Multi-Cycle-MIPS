library ieee;
use ieee.std_logic_1164.all; 

entity Control_Unit is 
	port(
		clk : in std_logic;
		op : in std_logic_vector(5 downto 0);
		PCWriteCond, PCWrite, IorD, MemRead, Memwrite, MemToReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic; 
		PCSource, ALUOp, ALUSrcB : out std_logic_vector(1 downto 0) 
	);	
end entity;


architecture behav of Control_Unit is 
type cycle is (FETCH, DECODE, EXECUTE, MEM_ACCESS, WRITE_BACK);
signal curr_state : cycle := FETCH;
begin 
	
process(clk, op) is
begin 
	if rising_edge(clk) then
		MemRead     <= '0';
        MemWrite    <= '0';
        RegWrite    <= '0';
        ALUSrcA     <= '0';
        ALUSrcB     <= "00";
        ALUOp       <= "00";  
		PCSource	<= "00"; 
        IRWrite     <= '0';
        PCWrite     <= '0';	  
		IorD        <= '0';
		PCWriteCond <= '0';	 
		MemToReg    <= '0';	
		RegDst      <= '0';
		case (curr_state) is 
			when FETCH => 
				IorD <= '0';
				MemRead <= '1';
				IRWrite <= '1';
				ALUSrcA <= '0';
				ALUSrcB <= "01";
				ALUOp <= "00";
				PCWrite <= '1'; 
				curr_state <= DECODE;
			when DECODE => 
				ALUSrcA <= '0';
				ALUSrcB <= "11";
				ALUOp <= "00";
				curr_state <= EXECUTE;
			when EXECUTE =>
				case op is 
					when "000010" =>  --jump 
						PCSource <= "10";
						PCWrite <= '1';
						curr_state <= FETCH;
						
					when "000100" =>  -- beq
						ALUSrcA <= '1';
						ALUSrcB <= "00";
						ALUOp <= "01";
						PCSource <= "01";
						PCWriteCond <= '1';
						curr_state <= FETCH;
						
					when "000000" =>  --R-type
						ALUSrcA <= '1';
						ALUSrcB <= "00";
						ALUOp <= "10";
						curr_state <= MEM_ACCESS;
		
					when "100011" | "101011" | "001000" => --i-type						
						ALUSrcA <= '1';
						ALUSrcB <= "10";
						ALUOp <= "00";
						curr_state <= MEM_ACCESS;									  
					when others => curr_state <= FETCH;
				end case;
			
			when MEM_ACCESS =>	
				case (op) is 
					when "000000" =>  	--R-type
						RegDst  <= '1';
						MemToReg <= '0';
						RegWrite <= '1';
						curr_state <= FETCH;
					when "001000" =>  	--addi
						RegDst  <= '0';
						MemToReg <= '0';
						RegWrite <= '1';
						curr_state <= FETCH;
					when "101011" =>	--sw
						IorD <= '1';
						MemWrite <= '1';
						curr_state <= FETCH;
					when "100011" => 	--lw
						IorD <= '1';
						MemRead <= '1';
						curr_state <= WRITE_BACK;
					when others => curr_state <= FETCH; 
				end case;
			
			when WRITE_BACK =>	
				case(op) is 
					when "100011" => --lw
						MemToReg <= '1'; 
						RegDst <= '0'; 
						Regwrite <= '1';
						curr_state <= FETCH;
					when others => curr_state <= FETCH;
				end case;
		end case;
	end if; 
end process;
	
end architecture;