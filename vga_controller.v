`timescale 1ns / 1ps


module vga_controller(
    input clock_at_100mhz,   // 100MHz clock input from the Basys 3 board
    input reset_button,        // System reset signal
    output video_on,    // High when x and y pixel counters are within the displayable area
    output horizontal_sync,       // Horizontal synchorizontal_syncpulseonization signal
    output vertical_sync,       // Vertical synchorizontal_syncpulseonization signal
    output p_tick,      // 25MHz pixel clock tick
    output [9:0] x_pixel,     // Current horizontal pixel position (range: 0-799)
    output [9:0] y_pixel      // Current vertical pixel position (range: 0-524)
    );
    
    // VGA standard parameters (640x480 resolution from VESA)
    // Total horizontal length = 800 pixels, divided into sections
    parameter horizontal_display = 640;             // Horizontal display area width (pixels)
    parameter horizontal_frontporch = 48;              // Horizontal front porch width (pixels)
    parameter horizontal_backporch = 16;              // Horizontal back porch width (pixels)
    parameter horizontal_syncpulse = 96;              // Horizontal sync pulse width (pixels)
    parameter HMAX = horizontal_display + horizontal_frontporch + horizontal_backporch + horizontal_syncpulse-1; // Maximum horizontal counter value (799)
    
    // Total vertical length = 525 pixels, divided into sections
    parameter vertical_display = 480;             // Vertical display area height (pixels)
    parameter vertical_frontporch = 10;              // Vertical front porch height (pixels)
    parameter vertical_backporch = 33;              // Vertical back porch height (pixels)
    parameter vertical_syncpulse = 2;               // Vertical sync pulse height (pixels)
    parameter VMAX = vertical_display + vertical_frontporch + vertical_backporch + vertical_syncpulse-1; // Maximum vertical counter value (524)
    
    // *** Generate 25MHz clock from 100MHz clock *********************************************************
    reg [1:0] r_25MHz;              // Counter to divide 100MHz by 4
    wire w_25MHz;                   // 25MHz clock signal
    
    always @(posedge clock_at_100mhz or posedge reset_button)
        if(reset_button)
          r_25MHz <= 0;
        else
          r_25MHz <= r_25MHz + 1;
    
    assign w_25MHz = (r_25MHz == 0) ? 1 : 0; // 25MHz tick is active for 1 out of every 4 clock cycles
    // ***************************************************************************************************
    
    // Horizontal and vertical counters to track pixel positions
    reg [9:0] h_count_reg, h_count_next; // Horizontal position counters
    reg [9:0] v_count_reg, v_count_next; // Vertical position counters
    
    // Output buffers for sync signals
    reg v_sync_reg, h_sync_reg;         // Registers for vertical and horizontal sync signals
    wire v_sync_next, h_sync_next;      // Next-state signals for sync outputs
    
    // Register Control
    always @(posedge clock_at_100mhz or posedge reset_button)
        if(reset_button) begin
            v_count_reg <= 0;           // Reset vertical counter
            h_count_reg <= 0;           // Reset horizontal counter
            v_sync_reg  <= 1'b0;        // Reset vertical sync
            h_sync_reg  <= 1'b0;        // Reset horizontal sync
        end
        else begin
            v_count_reg <= v_count_next; // Update vertical counter
            h_count_reg <= h_count_next; // Update horizontal counter
            v_sync_reg  <= v_sync_next;  // Update vertical sync signal
            h_sync_reg  <= h_sync_next;  // Update horizontal sync signal
        end
         
    // Horizontal counter logic
    always @(posedge w_25MHz or posedge reset_button) // Update on 25MHz clock tick
        if(reset_button)
            h_count_next = 0;            // Reset horizontal counter
        else
            if(h_count_reg == HMAX)      // Reset when horizontal scan reaches its maximum
                h_count_next = 0;
            else
                h_count_next = h_count_reg + 1; // Increment horizontal counter
  
    // Vertical counter logic
    always @(posedge w_25MHz or posedge reset_button)
        if(reset_button)
            v_count_next = 0;            // Reset vertical counter
        else
            if(h_count_reg == HMAX)      // Increment vertical counter at the end of a horizontal scan
                if(v_count_reg == VMAX)  // Reset at the end of a vertical scan
                    v_count_next = 0;
                else
                    v_count_next = v_count_reg + 1;
        
    // Horizontal sync signal active during the retrace interval
    assign h_sync_next = (h_count_reg >= (horizontal_display+horizontal_backporch) && h_count_reg <= (horizontal_display + horizontal_backporch+ horizontal_syncpulse-1));
    
    // Vertical sync signal active during the retrace interval
    assign v_sync_next = (v_count_reg >= (vertical_display + vertical_backporch) && v_count_reg <= (vertical_display + vertical_backporch + vertical_syncpulse-1));
    
    // Video signal enabled only when pixel counters are within the displayable area
    assign video_on = (h_count_reg < horizontal_display) && (v_count_reg < vertical_display); // Active in the range 0-639 and 0-479 respectively
            
    // Outputs
    assign horizontal_sync  = h_sync_reg;        // Horizontal sync output
    assign vertical_sync  = v_sync_reg;        // Vertical sync output
    assign x_pixel      = h_count_reg;       // Current horizontal pixel position
    assign y_pixel      = v_count_reg;       // Current vertical pixel position
    assign p_tick = w_25MHz;           // 25MHz pixel clock tick
            
endmodule
