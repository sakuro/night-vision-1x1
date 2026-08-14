-- Shrinks every night-vision-equipment prototype (vanilla and other mods') to a 1x1 grid slot,
-- so it runs after all mods have registered their equipment without needing explicit dependencies.
local function scale_sprite(sprite, factor)
  if sprite.layers then
    for _, layer in pairs(sprite.layers) do
      scale_sprite(layer, factor)
    end
  else
    sprite.scale = (sprite.scale or 1) * factor
  end
end

for _, equipment in pairs(data.raw["night-vision-equipment"] or {}) do
  local shape = equipment.shape

  -- Only square, rectangular ("full") shapes can be resized by scale alone.
  if shape and shape.type == "full" and shape.width == shape.height and shape.width ~= 1 then
    local factor = 1 / shape.width

    scale_sprite(equipment.sprite, factor)
    shape.width = 1
    shape.height = 1
  end
end
