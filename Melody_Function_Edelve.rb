
define :melody_edelve do | note_and_duration |
  
  _melody = note_and_duration.ring
  dur_melody = (_melody.length/2.0)
  
  tick_reset
  
  dur_melody.times do   
    play _melody.tick
    sleep _melody.tick 
  end

end
