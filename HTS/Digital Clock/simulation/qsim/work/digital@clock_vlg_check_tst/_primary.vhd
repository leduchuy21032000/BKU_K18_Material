library verilog;
use verilog.vl_types.all;
entity digitalClock_vlg_check_tst is
    port(
        HEX0            : in     vl_logic_vector(0 to 6);
        HEX1            : in     vl_logic_vector(0 to 6);
        HEX2            : in     vl_logic_vector(0 to 6);
        HEX3            : in     vl_logic_vector(0 to 6);
        HEX4            : in     vl_logic_vector(0 to 6);
        HEX5            : in     vl_logic_vector(0 to 6);
        HEX6            : in     vl_logic_vector(0 to 6);
        sampler_rx      : in     vl_logic
    );
end digitalClock_vlg_check_tst;
