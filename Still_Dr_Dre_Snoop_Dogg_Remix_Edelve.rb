# STILL :: Dr.Dre Snoop Dogg, remix by DJ_EDELVE - Sonic Pi #
# Ultra_Bass Idea (DJ_EDELVE)#

use_bpm 84
use_transpose 0.5
live_loop :drums, delay: 16 do
  sample :bd_tek, amp: 2, rate: 1.3, amp: 1; sleep 1
  sample :sn_dolf;  sleep 0.25
  sample :bd_tek, amp: 1;  sleep 0.25
  sample :bd_tek;  sleep 0.5
end

live_loop :boom, delay: 16 do
  sample :bd_sone, rate: 0.7, amp: 1.2, compress: 0
  sleep 4
end

live_loop :kiribati, delay: 16 do
  sample :elec_fuzz_tom, rate: 1, amp: 0.25 if (spread 5,7).tick
  sleep 0.25
end

with_fx :reverb, mix: 0.3, room: 0.5 do
  with_fx :compressor, pre_amp: 2 do
    live_loop :bass do
      
      time = (ring 3, 1, 3, 1, 3, 1)
      
      synth :hollow, note:  (ring :a2, :b2, :e2, :e2).tick, amp: 1,
        attack: 0.05, sustain: 0.3, decay: 0.3, release: 3.2
      synth :hollow, note:  (ring :a1, :b1, :e1, :e1).look, amp: 0.5, cutoff: 129,
        attack: 0.05, sustain: 0.3, decay: 0.3,   release: 3.2
      sleep time.look
    end
  end
  
end
with_fx :reverb, mix: 0.5, room: 0.1 do
  with_fx :compressor, pre_amp: 1.2 do
    live_loop :strings, delay: 8 do
      
      time = (ring 3, 1, 3, 1, 3, 1)
      
      synth :dark_ambience, note:  (ring :a4, :a4, :g4, :r).tick,
        amp: 2, attack: 0.05, release: 1.5, pan: -0.75
      synth :dark_ambience, note:  (ring :a3, :a3, :g3, :r).look,
        amp: 2, attack: 0.05, release: 1.5, pan: 0
      synth :dark_ambience, note:  (ring :a3, :a3, :g3, :r).look,
        amp: 2, attack: 0.05, release: 1.5, pan: 0.75
      sleep time.look
      
    end
  end
end

with_fx :reverb, mix: 0.4, room: 0.2 do
  with_fx :distortion, distort: 0.2 do
    live_loop :ultrabass, delay: 24 do
      use_transpose 0
      tick
      r1 = (knit :a2, 4, :b2, 2, :e1, 2, :e2, 2)
      r2 = (knit :a1, 4, :b1, 2, :e0, 2, :e1, 2)
      
      synth :fm, note: r1.tick , divisor: 7, depth: 4, amp: 1,  
        release: 0.24 if (spread 8,11).look  
      sleep 0.25
    end
  end
end

with_fx :reverb, mix: 0.4, room: 0.5 do
  with_fx :bpf, centre: 119, pre_amp: 10 do
    live_loop  :piano do
      p = 1.0/3
      with_fx :ping_pong, mix: 0.1,  ## Mix for dry-wet signal
      phase: p, feedback: 0.5, pan_start: rdist(1, 0), reps: 16 do
        a, b, c = (chord :a4, :minor, invert: 1),
          ([:b4,:e5, :a5]),
          (chord :e4, :minor, invert: 2)
        
        synth :piano, note: (knit  a, 8, b, 3, c,5).tick, release: 0.5,
          sustain: 0.001, attack: 0.001, decay: 0.001, amp: 2
        sleep 0.5
      end
    end
  end
end
