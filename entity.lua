local Entity = {}
Entity.__index = Entity


function Entity:new(world, size, x, y, angle)

    local entity = setmetatable({}, Entity)

    entity.b = love.physics.newBody(world, x, y, "dynamic")
    entity.b:setMass(50)
    entity.b:setAngle(angle)
    entity.s = love.physics.newRectangleShape(size, size)
    entity.f = love.physics.newFixture(entity.b, entity.s)
    entity.f:setRestitution(0.7)

    return entity

end


function Entity:bounce()
    self.b:applyLinearImpulse(0, -5000)
end


function Entity:hasMouseOver()
    local x, y = love.mouse.getPosition()
    return self.f:testPoint(x, y)
end


function Entity:draw()
    love.graphics.polygon("line", self.b:getWorldPoints(self.s:getPoints()))
end


return Entity
