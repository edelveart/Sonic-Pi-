# ANIMALS by M. GARRIX #

# DJ EDELVE 2022 Sonic Pi - REMIX ON FIRE #

use_bpm 125
use_debug true

set_mixer_control! hpf: 95*0, hpf_slide: 8.0/32
set_volume! 1

################################
## DRUMS ON FIRE ##
with_fx :reverb, mix: 0.45, room: 0.1 do
  with_fx  :distortion, distort: 0.1, mix: 1 do
    live_loop :centraldrum, delay: 24 do
      ## Soft groove 0,3,1
      ## Hard groove 3,0,2
      a, b, c = 5, 0, 1
      sample :bd_haus, amp: a, compress: 1,
        pan: 0.1,
        cutoff: 120,  rate: 0.98, release: 1
      sample :bd_tek, amp: b, compress: 0,
        pan: 0.1,
        cutoff: 120,  rate: 1,  release: 1
      sample :bd_sone, amp: c, compress: 1,
        pan: 0.1,
        cutoff: 120,  rate: 0.8, release: 1
      sleep 1
    end
  end
end

#######################################
## SNAPPPPPP ON FIRE##
with_fx :reverb, mix: 0.2, room: 0.9 do
  live_loop :snaps, delay: 8, sync: :centraldrum do
    s = (ring 0,1)
    # s = (ring 0, 1, 1, 0, 0, 1)
    
    sample :perc_snap2,
      amp: s.tick, compress: 0, pan: 0.25 * 1
    sample :perc_snap,
      amp: s.look, compress: 0, pan: 0.25 * -1
    
    sample :sn_dub, amp: s.look
    sleep 1
    
  end
end

#######################################
## SPLASH ON FIRE ##
with_fx :reverb, mix: 0.1, room: 0.1 do
  live_loop :splash, delay: 8 do
    
    s = (ring 0,0.25).reverse
    sample :drum_cymbal_closed,
      amp: s.tick, compress: 0, pan: rdist(0.7,0.1)
    sample :drum_cymbal_closed,
      amp: s.look, compress: 0, pan: rdist(0.7 * -1, 0.1)
    sleep 0.5
  end
end

###########################################
### 2-BASS ON FIRE ###
with_fx :reverb, mix: 0.5, room: 0.2 do
  with_fx :distortion, distort: 0.5 do
    live_loop :Red1, delay: 8 do
      a = 0.7 * 1
      m = (ring 0.5, 0.5, 0.25, 0.75,
           0.5, 0.75, 0.25, 0.5, 0.25).stretch(1)
      synth :fm,
        note: :d2,
        amp: a, divisor: 2, depth: 1.3*1,
        release: 0.35,
        attack: 0, sustain: 0, decay: 0
      sleep m.tick
    end
  end
end

with_fx :reverb, mix: 0.45, room: 0.2 do
  with_fx :distortion, distort: 0.5 do
    live_loop :Red2, delay: 16 do
      a = 2 * 1
      m = (ring 0.5, 0.5, 0.25, 0.75,
           0.5, 0.75, 0.25, 0.5, 0.25).reverse
      n = (ring 1, 0.5, 0.5)
      synth :sine, note: :d1,
        amp: a,
        release: 0.35,
        attack: 0.05, sustain: 0, decay: 0
      sleep (n).tick
    end
  end
end

#######################################
## SAW ON FIRE ##
with_fx :reverb, mix: 0.4, room: 0.7 do
  live_loop :saw_on_fire do
    use_random_seed 4213
    b = (bools 1, 0, 1, 1, 0, 1).stretch(2)
    8.times do
      
      synth :dsaw,  note: :d3,
        amp: 0.35 * 2, pan: [-0.35,0.35].look,
        attack: 0.012, decay: 0.1,
        sustain: 0.01,
        release: 0.25 if b.tick
      
      sleep 0.25
    end
  end
end

#######################################
## ARP_EDELVE ON FIRE ##
live_loop :arpeg_edelve_on_fire, delay: 32, sync: :saw_on_fire do
  with_fx :reverb, mix: 0.6, room: 0.9, damp: 0.7 do
    use_random_seed 18 + 9645
    
    dur = 4
    8.times do
      synth (ring :kalimba, :blade).drop(1).choose,
        note: (chord :d4, :minor,
               num_octaves: 1, invert: rrand_i(0,2)).stretch(2).choose,
        amp: 1.5 * 1, attack: 0.0,
        pan: rdist(0.2, (ring 0.3, -0.3).choose),
        decay: 0, sustain: 0,
        release: rrand(1.0/dur, 0.5) if (spread 7,13).tick
      sleep 1.0/dur
    end
    ## Move n.times, move: invert, move: soread, move: release.
  end
end

#####################################
## BASSUS ON FIRE ---- CONTROL ##
live_loop :ultra_bassus_control, delay: 48 do
  with_fx :distortion, distort: 0.4 do
    density 2 do
      b = synth :chipbass,  note: :d1,
        amp: 0.2 * 2,
        sustain: 3.8, release: 0.2,
        pan:  (line -0.4,0.4, steps: 8,
               inclusive: true).reflect.tick;   sleep 0.5
      control b, note: :d2, note_slide: 1;      sleep 1
      control b, note: :d1, note_slide: 1;      sleep 1
      control b, note: :d2, note_slide: 0.5;    sleep 0.5
      control b, note: :d3, note_slide: 0.25;   sleep 1
    end
  end
end

#########################
#### LEAD_GARRIX ####
live_loop :martinpulse, delay: 0 do
  with_fx :reverb, mix: 0.6, room: 0.7 do
    
    with_fx :ping_pong, phase: 0.25 do
      with_fx :distortion, distort: 0.7 do
        with_fx :bitcrusher, bits: 0.9 do
          use_synth :dpulse
          a = 0.7
          r = 0.08
          play_pattern_timed [
            :r, :a5, :a5, :a5,
            :a5, :g5, :g5, :g5,  :f5, :f5, :d5, :r,
            :a5, :a5, :a5, :a5,
            :g5, :g5, :g5,
          :bb5, :a5  ],
            [1, 0.25,0.25,0.25,0.25,
             0.25, 0.5, 0.25, 0.5, 0.25, 0.25,
             1, 0.25,0.25,0.25,0.25,
             0.25,0.5,0.25, 0.5,0.5],
            release: r, attack: 0,
            sustain: 0, decay: 0, amp: a
        end
      end
    end
  end
end

#####################################
## DRONE ON FIRE ##
live_loop :ultra_drone, delay: 0 do
  s = sample :ambi_drone,rpitch: :d1,
    amp: (line 0.12,0.22, steps: 4).reflect.tick,
    pan: rdist(0.45)
  sleep 0.5
  control s, amp: 0.4, amp_slide: 0.25
  sleep 0.5
end
