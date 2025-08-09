-- vhdl-linter-disable type-resolved

-- Entity for the registers as part of the minimal RV32I subset of RISC-V
-- Contains 32 registers each of 32 bits created via an array.
-- The signal for the array is x i.e. x0 = x(0), x1 = x(1) etc.

-- rs1,rs2 and rd are indexes (similar to pointers) of 5-bits (2^5 = 32)
-- wd, rd1 and rd2 are values (data) thus are 32-bits.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gp_registers is

    port(
    clk : in std_logic;
    we  : in std_logic; -- write enable
    rs1 : in unsigned(4 downto 0); -- read source register 1. Essentially a pointer (index value).
    rs2 : in unsigned(4 downto 0); -- selects which register’s value will appear on output rd2.
    rd  : in unsigned(4 downto 0); -- write destination. Selects which register will receive the value from wd
    wd  : in std_logic_vector(31 downto 0); -- The value to be written into register rd on the next clock (we=1).
    rd1 : out std_logic_vector(31 downto 0); -- read out data stored in rs1.
    rd2 : out std_logic_vector(31 downto 0)  -- read out data stored in rs2.
    );
end entity;

architecture registers of gp_registers is
    type reg_array is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal x : reg_array;

    begin

        x(0) <= (others => '0'); -- x0 is always a register of 0´s.
        rd1 <=  x(0) when rs1 = (others=>'0') else x(rs1); -- output rd1 = data inside register x(rs1).
        rd2 <=  x(0) when rs2 = (others=>'0') else x(rs2);
    
    write_dest_process: process(clk)
    begin
        if (rising_edge(clk)) then
            if we = '1' and rd /=(others => '0') then
                x(rd) <= wd; -- register with index of rd, gets the value of wd.
            end if;
    end if;
end process;
end architecture registers;
