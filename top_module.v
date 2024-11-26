`timescale 1ns / 1ps

module top(
    input clock_at_100mhz,       // Clock input from Basys 3 board
    input reset_button,            // reset_button_button signal (btnR)
    input up_direction,               // Button to move up (btnU)
    input down_direction,             // Button to move down (btnD)
    output horizontal_sync,           // Horizontal synchronization signal for VGA
    output vertical_sync,           // Vertical synchronization signal for VGA
    output [11:0] rgb       // RGB color output to the VGA DAC
    );
    
    wire w_reset_button, w_up_direction, w_down_direction, w_vid_on, w_p_tick;
    wire [9:0] w_x, w_y;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // VGA controller to generate synchronization signals and pixel positions
    vga_controller vga(.clock_at_100mhz(clock_at_100mhz), .reset_button(w_reset_button), .video_on(w_vid_on),
                       .horizontal_sync(horizontal_sync), .vertical_sync(vertical_sync), .p_tick(w_p_tick), .x_pixel(w_x), .y_pixel(w_y));
                       
    // Pixel generator to define RGB values based on the current pixel position and control signals
    pixel_gen pg(.clock(clock_at_100mhz), .rst(w_reset_button), .up_direct(w_up_direction), .down_direct(w_down_direction), 
                 .video_on(w_vid_on), .x_pixel(w_x), .y_pixel(w_y), .rgb(rgb_next));
                 
    // Debounce modules to process button inputs and eliminate noise
    debounce dbR(.clk(clock_at_100mhz), .btn_in(reset_button), .btn_out(w_reset_button));
    debounce dbU(.clk(clock_at_100mhz), .btn_in(up_direction), .btn_out(w_up_direction));
    debounce dbD(.clk(clock_at_100mhz), .btn_in( down_direction), .btn_out(w_down_direction));
    
    // Buffer to store RGB values and update them on each pixel tick
    always @(posedge clock_at_100mhz)
        if(w_p_tick)
            rgb_reg <= rgb_next;
            
    // Assign the buffered RGB value to the output
    assign rgb = rgb_reg;
    
endmodule
