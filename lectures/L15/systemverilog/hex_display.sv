/**
 * @brief System for displaying two hexadecimal numbers 0 - F via hex displays.
 *        The number displayed on each display is entered in 4-bit binary form
 *        via four slide switches.
 *
 * @param[in] inputs Eight slide-switches used for entering two 4-bit numbers.
 * @param[out] hex1 The first hex display, controlled by inputs[7:4].
 * @param[out] hex0 The second hex display, controlled by inputs[3:0].
 */
module hex_display(input logic[7:0] inputs,
                   output logic[6:0] hex1, hex0);         
    // Implement hardware for hex1[6:0], which is controlled by inputs[7:4].  
    display display1(inputs[7:4], hex1);
    
    // Implement hardware for hex0[6:0], which is controlled by inputs[3:0].  
    display display0(inputs[3:0], hex0);
endmodule
