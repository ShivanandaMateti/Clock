# 12-Hour Digital Clock (Verilog)
Project Overview

A synchronous 12-hour digital clock implemented in Verilog HDL. The design uses a modular hierarchy of BCD counters to track time and features an accurate AM/PM indicator driven by an internal 24-hour reference cycle.

Features & Specifications

12-Hour Display: Tracks hours (hh), minutes (mm), and seconds (ss) in standard 12-hour BCD format.
AM/PM Logic: Uses an internal 5-bit 24-hour counter to precisely toggle the pm flag, avoiding common edge-case bugs.
Synchronous Control: Fully synchronous operation with active-high master enable (ena) and active-high reset (defaults to 12:00:00).
Modular Design: Utilizes dedicated, reusable sub-counters (bcd_counter_9 and bcd_counter_5) for clear cascading logic.

Architecture & Interface

Block Hierarchy

top_module: Main controller handling time cascading, hour indexing (12 $\rightarrow$ 1 rollover), and AM/PM logic.
bcd_counter_9: Modulo-10 counter (0–9) for the Least Significant Digits (LSD).
bcd_counter_5: Modulo-6 counter (0–5) for the Most Significant Digits (MSD).

Inputs & Outputs

Inputs: clk (system clock), reset (master reset), ena (count enable).
Outputs: pm (0 = AM, 1 = PM), hh[7:0] (Hours BCD), mm[7:0] (Minutes BCD), ss[7:0] (Seconds BCD).

Simulation Verification

Functional simulation waveforms confirm:

Accurate Rollover: Perfect cascading transitions at 59 seconds, 59 minutes, and 12 hours.
Control Lines: Clock holds state instantly when ena goes low and cleanly defaults on reset.
AM/PM Alignment: The pm bit transitions accurately as the internal tracking register crosses the mid-day boundary.
