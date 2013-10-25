load_library :video
include_package 'processing.video'

attr_reader :mov, :color_shader, :half_x, :half_y, :img, :a, :do_record, :mm

def setup

  size(1280, 720, P3D) 
  no_stroke  

  @color_shader = loadShader('purplefrag.glsl', 'purplevert.glsl');
  @color_shader.set('resolution', width.to_f, height.to_f);
  @mov = Movie.new(self, 'fireworks_apple_video.mov')

  @do_record = false
  directory = "output"
  Dir::mkdir(directory) unless File.exists?(directory) 

  @img = create_image(1280, 720, ARGB)
  @img.load_pixels
  @img.pixels.length.times do |i|
    @img.pixels[i] = color(0,0,0,10)
  end
  @img.update_pixels

  @mov.loop
  @mov.volume 0

  @half_x = 640
  @half_y = 360

  @a = 0.0
  texture_wrap(REPEAT)
  background 0

end

# Display values from movie
def draw

  x_mouse = mouse_x - @half_x
  y_mouse = mouse_y - @half_y
  @color_shader.set('mouse', x_mouse.to_f, y_mouse.to_f)
  @color_shader.set('time', millis / 1000.0)

  if @mov.available? then

    blendMode(LIGHTEST)

    push_matrix
      @a += 0.01;
      if(@a > TWO_PI) then @a = 0.0 end

      translate(width/2, height/2)
      rotateX(@a * 4.0)
      rotateY(@a * 4.0)

      shader(@color_shader)
        @mov.read
        image(@mov, -640, -360, width, height)
      reset_shader
    pop_matrix

    blendMode(BLEND)
    image(@img, 0, 0)

  end

  if @do_record 
    save_frame("output/frames####.png".to_java)
  end

end

def key_pressed
  if key == 'r' then
    if !@do_record
      @do_record = !@do_record
    else
      @do_record = !@do_record
    end
  end
end
