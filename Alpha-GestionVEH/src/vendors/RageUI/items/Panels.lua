---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

---@class Panels
Panels = {};

local GridType = {
    Default = 1,
    Horizontal = 2,
    Vertical = 3
}

local GridSprite = {
    [GridType.Default] = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", },
    [GridType.Horizontal] = { Dictionary = "RageUI_", Texture = "horizontal_grid", },
    [GridType.Vertical] = { Dictionary = "RageUI_", Texture = "vertical_grid", },
}

local Grid = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
        Left = { X = 57.75, Y = 130, Scale = 0.35 },
        Right = { X = 373.25, Y = 130, Scale = 0.35 },
    },
}

local function UIGridPanel(Type, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if (CurrentMenu.Index == Index) then
        local X = Type == GridType.Default and StartedX or Type == GridType.Horizontal and StartedX or Type == GridType.Vertical and 0.5
        local Y = Type == GridType.Default and StartedY or Type == GridType.Horizontal and 0.5 or Type == GridType.Vertical and StartedY
        local Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + Grid.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20, Grid.Grid.Width + CurrentMenu.WidthOffset - 40, Grid.Grid.Height - 40)
        local Selected = false
        local CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20
        local CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20
        if X < 0.0 or X > 1.0 then
            X = 0.0
        end
        if Y < 0.0 or Y > 1.0 then
            Y = 0.0
        end
        CircleX = CircleX + ((Grid.Grid.Width - 40) * X) - (Grid.Circle.Width / 2)
        CircleY = CircleY + ((Grid.Grid.Height - 40) * Y) - (Grid.Circle.Height / 2)
        Graphics.Sprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Background.Width + CurrentMenu.WidthOffset, Grid.Background.Height)
        Graphics.Sprite(GridSprite[Type].Dictionary, GridSprite[Type].Texture, CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Grid.Width, Grid.Grid.Height)
        Graphics.Sprite(Grid.Circle.Dictionary, Grid.Circle.Texture, CircleX, CircleY, Grid.Circle.Width, Grid.Circle.Height)
        if (Type == GridType.Default) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Vertical) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Horizontal) then
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if Hovered then
            if IsDisabledControlPressed(0, 24) then
                Selected = true
                CircleX = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (Grid.Circle.Width / 2)
                CircleY = math.round(GetControlNormal(2, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (Grid.Circle.Height / 2)
                if CircleX > (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40
                elseif CircleX < (CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)
                end
                if CircleY > (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40
                elseif CircleY < (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)
                end
                X = math.round((CircleX - (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20) + (Grid.Circle.Width / 2)) / (Grid.Grid.Width - 40), 2)
                Y = math.round((CircleY - (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20) + (Grid.Circle.Height / 2)) / (Grid.Grid.Height - 40), 2)
                if (X ~= StartedX) and (Y ~= StartedY) then
                    Action(X, Y, (X * 2 - 1), (Y * 2 - 1))
                    --	Action.onPositionChange(X, Y, (X * 2 - 1), (Y * 2 - 1))
                end
                StartedX = X;
                StartedY = Y;
                if X > 1.0 then
                    X = 1.0
                end
                if Y > 1.0 then
                    Y = 1.0
                end
            end
        end
        RageUI.ItemOffset = RageUI.ItemOffset + Grid.Background.Height + Grid.Background.Y
        if Hovered and Selected then
            Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
            --if (Action.onSelected ~= nil) then
            --	Action.onSelected(X, Y, (X * 2 - 1), (Y * 2 - 1));
            --end
        end
    end
end

---@type number
function Panels:renderSprite(TextureDictionary, TextureName, X, Y, Width, Height, Heading, R, G, B, A)
    local CurrentMenu = RageUI.CurrentMenu;
    local X, Y, Width, Height = (tonumber(X) or 0) / 1920, (tonumber(Y) or CurrentMenu.Y + RageUI.Settings.Items.Description.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 3) / 1080, (tonumber(Width) or 434) / 1920, (tonumber(Height) or 200) / 1080

    if not HasStreamedTextureDictLoaded(TextureDictionary) then
        RequestStreamedTextureDict(TextureDictionary, true)
    end

    DrawSprite(TextureDictionary, TextureName, X + Width * 0.5, Y + Height * 0.5, Width, Height, Heading or 100, tonumber(R) or 255, tonumber(G) or 255, tonumber(B) or 255, tonumber(A) or 255)
end

---Grid
---@param StartedX number
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:Grid(StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Default, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
end

---GridHorizontal
---@param StartedX number
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridHorizontal(StartedX, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Horizontal, StartedX, nil, nil, nil, LeftText, RightText, Action, Index)
end

---GridVertical
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridVertical(StartedY, TopText, BottomText, Action, Index)
    UIGridPanel(GridType.Vertical, nil, StartedY, TopText, BottomText, nil, nil, Action, Index)
end

local Statistics = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
    Text = {
        Left = { X = -40, Y = 70--[[15]], Scale = 0.35 },
    },
    Bar = { Right = 8, Y = 80--[[27]], Width = 200, Height = 10 , OffsetRatio = 0.5 },
    Divider = {
        [1] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [2] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [3] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [4] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [5] = { X = 200, Y = 27, Width = 2, Height = 10 },
    }
}

---StatisticPanel
---@param Percent number
---@param Text string
---@param Index number
---@return void
---@public
function Panels:StatisticPanel(Percent, Text, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu.Index == Index or not Index then
            ---@type number
            local BarWidth = Statistics.Bar.Width + CurrentMenu.WidthOffset * Statistics.Bar.OffsetRatio
            Graphics.Rectangle(CurrentMenu.X, (CurrentMenu.Y + 10) + Statistics.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            Graphics.Text(Text or "", CurrentMenu.X + 8.0, (RageUI.StatisticPanelCount * 40) + (CurrentMenu.Y - 50) + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            Graphics.Rectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + (CurrentMenu.Y - 50) + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, BarWidth, Statistics.Bar.Height, 87, 87, 87, 255)
            Graphics.Rectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset,  (RageUI.StatisticPanelCount * 40) + (CurrentMenu.Y - 50) + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent * BarWidth, Statistics.Bar.Height, 255, 255, 255, 255)
            for i = 1, #Statistics.Divider, 1 do
                Graphics.Rectangle((CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right) + i * ((BarWidth-(#Statistics.Divider/Statistics.Divider[i].Width))/(#Statistics.Divider+1)) + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + (CurrentMenu.Y + 3) + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end



---StatisticPanelAdvanced
---@param Percent number
---@param RGBA1 Table {R,G,B,A}
---@param Percent2 number
---@param RGBA2 Table {R,G,B,A}
---@param RGBA3 Table {R,G,B,A}
---@param Text string
---@param Index number
---@return void
---@public
function Panels:StatisticPanelAdvanced(Text, Percent, RGBA1, Percent2, RGBA2, RGBA3, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if (CurrentMenu.Index == Index) then


            RGBA1 = RGBA1 or {255,255,255,255}
            local BarWidth = Statistics.Bar.Width + CurrentMenu.WidthOffset * Statistics.Bar.OffsetRatio

            --[[ METHOD FOR CHECK IF THE STRING IS NOT TO LONG (and correct if it is) BUT USE WAY TOO MUCH CPU
                local textSize, textChar = MeasureStringWidth(Text, 0, Statistics.Text.Left.Scale), GetCharacterCount(Text)
                local maxTextSize = RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset - (CurrentMenu.X + 8.0 + BarWidth + Statistics.Bar.Right)
                if textSize > maxTextSize then
                    for i = textChar, 1, -1 do
                        local tempText = string.sub(Text, 0, i) .. "..."
                        local tempTextSize = string.len(tempText)
                        if MeasureStringWidth(tempText, 0, Statistics.Text.Left.Scale) < maxTextSize then
                            Text = tempText
                            break
                        end
                    end
                end
            ]]

            ---@type number
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Statistics.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            RenderText(Text or "", CurrentMenu.X + 8.0, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderRectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, BarWidth, Statistics.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset,  (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent * BarWidth, Statistics.Bar.Height, RGBA1[1], RGBA1[2], RGBA1[3], RGBA1[4])
            RGBA2 = RGBA2 or {0, 153, 204,255}
            RGBA3 = RGBA3 or {185, 0, 0,255}

            if Percent2 and Percent2 > 0 then
                local X = CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset+ Percent * BarWidth
                RenderRectangle(X, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA2[1], RGBA2[2], RGBA2[3], RGBA2[4])
            elseif Percent2 and Percent2 < 0 then
                local X = CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset+ Percent * BarWidth
                RenderRectangle(X, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA3[1], RGBA3[2], RGBA3[3], RGBA3[4])
            end

            for i = 1, #Statistics.Divider, 1 do
                RenderRectangle((CurrentMenu.X + RageUI.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right) + i * ((BarWidth-(#Statistics.Divider/Statistics.Divider[i].Width))/(#Statistics.Divider+1)) + CurrentMenu.WidthOffset, (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end

            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end


