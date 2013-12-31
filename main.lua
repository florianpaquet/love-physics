local Entity = require("entity")
local world, floor, entities, entityHover


function love.load()

    -- Create world
    world = love.physics.newWorld(0, 9.81 * 64, true)

    -- Create world boundaries
    left_border = {}
        left_border.b = love.physics.newBody(world, 0, 0, "static")
        left_border.s = love.physics.newEdgeShape(0, 300, 550, 800)
        left_border.f = love.physics.newFixture(left_border.b, left_border.s)

    right_border = {}
        right_border.b = love.physics.newBody(world, 0, 0, "static")
        right_border.s = love.physics.newEdgeShape(750, 800, 1200, 300)
        right_border.f = love.physics.newFixture(right_border.b, right_border.s)

    -- Create entity
    entities = {}

    for i=1, 100 do
        local size, x, y, angle = love.math.random(20, 80), love.math.random(150, 800), love.math.random(30, 400), love.math.random(0, 20)
        entities[i] = Entity(world, size, x, y, angle)
    end

end


function love.update(dt)

    -- Update world
    world:update(dt)

end


function love.mousepressed(x, y, button)

    -- Mouse events
    if button == "l" and entityHover then
        entityHover:bounce()
    end

end


function love.draw()

    entityHover = nil

    -- Draw world boundaries
    love.graphics.line(right_border.b:getWorldPoints(right_border.s:getPoints()))
    love.graphics.line(left_border.b:getWorldPoints(left_border.s:getPoints()))

    -- Draw entities

    for i=1, #entities do

        if entities[i]:hasMouseOver() then
            entityHover = entities[i]
            love.graphics.setColor(255, 0, 0)
        else
            love.graphics.setColor(255, 255, 255)
        end

        entities[i]:draw()

    end

    -- Debug
    love.graphics.print("FPS : " .. love.timer.getFPS(), 10, 10)

end
