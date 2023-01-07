

## True and False by DJ_ Edelve ##

## Composition by DJ_Edelve ##

use_bpm 67

set_volume! 2
set_mixer_control! hpf: 0, hpf_slide: 4


with_fx :reverb, mix: 0.38, room: 0.7, damp: 0.99 do
live_loop :ultra_melody_bools, delay: 0 do

use_random_seed 7**2
t = 3
	with_fx :slicer, phase: 1.0/8, reps: 16 do
	t.times do
		synth :supersaw, 
		note: (scale :a3, :minor, 
			invert: [1].tick("octs"),
			num_octaves: 1).take(t).stretch(2).choose,#shuffle.tick("bools"),
			release: rrand(0.25, 0.3),
			pan: rdist(1),
			amp: rrand(0.6,0.7)*1.1 if (spread 4,8).rotate(1).tick
			
			sleep 0.125
			end
		end
	end
end


with_fx :reverb, mix: 0.49, room: 0.95 do
live_loop :bools_game, delay: 8 do

	use_random_seed 10

	b1 = (bools 1, 0, 1, 0).rotate(0)
	b2 = (bools 0, 1, 1, 1).rotate(1)
	number_notes = (b1+b2).length

	number_notes.times do
		sounds_rand = (knit :dsaw, 1, :chiplead, 1, :mod_dsaw, 1)
		a = (line 1,0.5, inclusive: true, steps: 4)
		off_autotune = rand(0.2)
		pan_widt = rand(0.9); pan_cent = rand(0.1)
		dur = 8
		
		synth sounds_rand.choose,
		note: 
		(chord :a2, :minor, 
			inverse: 0).tick("chord_melody") + 
			off_autotune,
			amp: a.look,
			pan: rdist(pan_widt, pan_cent),
			release: 1.0/dur if (b1+b2).tick
			sleep 1.0/dur
		end
	end
end

with_fx :reverb, mix: 0.5, room: 0.3, damp: 0.9 do
	with_fx :nbpf, centre: 105, pre_amp: 0.7, mix: 0.7, res: 0.3 do
		with_fx :tanh, krunch: 0.9, pre_amp: 1 do
			live_loop :bools_game2, delay: 16 do
				a = (line 0.75, 0.8, inclusive: true, steps: 4)
				dur = 8
				bass_b1 = (bools 1,1,0,0,1,1,1,1)
				bass_b2 = (bools 1,0,1,1,0,0,1,1)
				8.times do
					synth :fm, 
					note: (knit :a2, 7, :a3, 1, 
					:a2, 3, :a3, 1, :a2, 4).tick("notes"),
					release: 1.0/dur*(3.3/2), attack: 0, sustain: 0.0, decay: 0,
					amp: a.choose if (bass_b2*3+bass_b1*1).tick
					sleep 1.0/dur
				end
			end
		end
	end 
end


at 22 do
	sample :misc_cineboom, amp: 3
end

live_loop :bools_game3, delay: 24 do
	with_fx :reverb, mix: 0.0, room: 0.1 do
		
		dur = 4
		drum_b1 = (bools 1,0,1,0,1,0,1,0)
		drum_b2 =  (bools 1,0,1,0,1,0,1,0).rotate(1)
		drum_b3 =  (bools 1,0,1,0,1,0,1,0).rotate(0)
				
		pan_ul = (line 1,-1, inclusive: true, steps: 8).reflect
		
		drum_b1.length.times do
			samp_ul= (knit  :bd_haus, 1).reverse
			
			sample samp_ul.tick("bass_drum"),
			amp: 2.5,
			compress: rand_i(1),
			rate: 3.0/dur if drum_b1.stretch(1).tick
			
			sample :sn_generic , cutoff: 105, 
			amp: rrand(0.2,0.3),
			pan: 0 if drum_b2.stretch(3).look
					
			slice_div = 4
			with_fx :slicer, phase: 1.0/slice_div, 
			phase_offset: 1.0/2,
			pulse_width: (rrand 0.9,0.99) do
				am =  rrand(0.8,0.9)
				sample :sn_dub,
				pan: pan_ul.reflect.tick("pan2"),
				rpitch: :a0 + 0.7,
				amp: am, cutoff: (129) if drum_b3.look
				
			end
			sleep 1.0/dur
		end
	end
end

with_fx :slicer, phase: 1.0/8 do
	live_loop :lunar, delay: 0 do
		sample :ambi_lunar_land, amp: 0.3, 
		pan: rdist(0.4,0.1), rate: 0.9
		sleep 0.5
	end
end
