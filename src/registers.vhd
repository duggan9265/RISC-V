-- vhdl-linter-disable type-resolved

-- Entity for the registers as part of the minimal RV32I subset of RISC-V
-- Contains 32 resgisters each of 32 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is

    port(
    clk : in std_logic;
    we  : in std_logic; -- write enable
    rs1 : in std_logic_vector(4 downto 0); -- read source register 1. Essentially a pointer (index value).
    rs2 : in std_logic_vector(4 downto 0); -- selects which register’s value will appear on output rd2.
    rd  : in std_logic_vector(4 downto 0); -- write destination. Selects which register will receive the value from wd
    wd  : in std_logic_vector(4 downto 0); -- The value to be written into register rd on the next clock (we=1)
    rd1 : out std_logic_vector(4 downto 0); -- read out data stored in rs1
    rd2 : out std_logic_vector(4 downto 0)  -- read out data stored in rs2
    );
end entity;

architecture registers of registers is
    type reg_array is array (31 downto 0) of unsigned(31 downto 0);
    begin

    end architecture;
