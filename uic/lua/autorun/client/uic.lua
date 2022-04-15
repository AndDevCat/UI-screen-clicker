do
    local active
    local leave = function()
        active = nil
        gui.EnableScreenClicker(false)
        hook.Remove("GUIMousePressed", "ADC::MouseSelector")
        hook.Remove("HUDPaint", "ADC::MonitorPosSelector")
    end

    local matWireframe = Material("models/wireframe")
    concommand.Add("click_pos_selector", function(ply)
        if (active) then return leave() end

        local x, y = 0, 0
        gui.EnableScreenClicker(true)
        active = 1

        hook.Add("GUIMousePressed", "ADC::MouseSelector", function(mouse)
            if (mouse ~= MOUSE_LEFT) then return end

            local sx, sy = input.GetCursorPos()
            hook.Add("HUDPaint", "ADC::MonitorPosSelector", function()
                local x, y = input.GetCursorPos()
                if (input.IsMouseDown(MOUSE_LEFT) == false) then
                    print("Start X:", sx, "Start Y:", sy, "Width:", x, "Height:", y)
                    return leave()
                end

                surface.SetDrawColor(color_white)
                surface.SetMaterial(matWireframe)
                surface.DrawTexturedRect(sx, sy, x - sx, y - sy)
            end)
        end)
    end)
end