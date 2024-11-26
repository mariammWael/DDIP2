`timescale 1ns / 1ps

module pixel_gen(
    input clock,  
    input rst,    
    input up_direct,
    input down_direct,
    input video_on,
    input [9:0] x_pixel,
    input [9:0] y_pixel,
    output reg [11:0] rgb
    );
    
    // Maximum x and y values within the displayable area
    parameter X_MAX_WINDOW = 639;
    parameter Y_MAX_WINDOW = 479;
    
    // Generate a 60Hz refresh tick signal
    wire refresh_tick;
    assign refresh_tick = ((y_pixel == 481) && (x_pixel == 0)) ? 1 : 0; // Signal for the start of vertical sync (vsync)
    
    // WALL
    // Define the boundaries of the wall
    parameter X_WALL_LEFT = 32;    
    parameter X_WALL_RIGHT = 39;    // The wall is 8 pixels wide
    
    // PADDLE
    // Define horizontal boundaries of the paddle
    parameter X_PAD_LEFT = 600;
    parameter X_PAD_RIGHT = 603;    // The paddle is 4 pixels wide
    // Signals for the paddle's top and bottom boundaries
    wire [9:0] y_pad_t, y_pad_b;
    parameter PAD_H = 72;  // Paddle height is 72 pixels
    // Registers for tracking the paddle's top position and its next position
    reg [9:0] y_pad_reg, y_pad_next;
    // Paddle movement speed when a button is pressed
    parameter PAD_V = 3;     // Adjust this value to change paddle movement speed
    
    // Register control logic for paddle position
    always @(posedge clock or posedge rst)
        if(rst) begin
            y_pad_reg <= 0;  // Reset paddle to initial position
        end
        else begin
            y_pad_reg <= y_pad_next;  // Update paddle position
        end
    
    // OBJECT STATUS SIGNALS
    wire pad_on;                 // Indicates if the current pixel corresponds to the paddle
    wire [11:0] pad_rgb, bg_rgb; // Colors for the paddle and background
    
    assign pad_rgb = 12'h0FF;    // Paddle color (gray)
    assign bg_rgb = 12'h00F;     // Background color (near black)
    
    // Determine paddle boundaries
    assign y_pad_t = y_pad_reg;                             // Top boundary of the paddle
    assign y_pad_b = y_pad_t + PAD_H - 1;                   // Bottom boundary of the paddle
    assign pad_on = (X_PAD_LEFT <= x_pixel) && (x_pixel <= X_PAD_RIGHT) && // Check if the pixel is within paddle's horizontal range
                    (y_pad_t <= y_pixel) && (y_pixel <= y_pad_b);          // Check if the pixel is within paddle's vertical range
                    
    // Paddle movement control
    always @* begin
        y_pad_next = y_pad_reg;  // Default: No movement
        if(refresh_tick) begin   // Only move paddle on a refresh tick
            if(up_direct & (y_pad_t > PAD_V))               // If "up" button is pressed and paddle is not at the top
                y_pad_next = y_pad_reg - PAD_V;             // Move the paddle up
            else if(down_direct & (y_pad_b < (Y_MAX_WINDOW - PAD_V))) // If "down" button is pressed and paddle is not at the bottom
                y_pad_next = y_pad_reg + PAD_V;             // Move the paddle down
        end
    end
    
    // RGB output logic
    always @*
        if(~video_on)
            rgb = 12'h000;          // Blank screen when video is off
        else
            begin 
        if(pad_on)
            rgb = pad_rgb;          // Display paddle color
        else
            rgb = bg_rgb;           // Display background color
       end
endmodule
