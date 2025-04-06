-- Define the asset ID (as a string) and desired position
local assetID = "77469151497420"
local targetPosition = Vector3.new(-83, -64, -177)

-- Load the asset (returns a table; we take the first object)
local loadedObjects = game:GetObjects("rbxassetid://" .. assetID)
local model = loadedObjects[1]

if model then
    -- Parent the model to the workspace so it's visible in-game
    model.Parent = workspace

    -- Check if the loaded object is a Model
    if model:IsA("Model") then
        -- If the model has a PrimaryPart, use PivotTo to set its position
        if model.PrimaryPart then
            model:PivotTo(CFrame.new(targetPosition))
        else
            -- If not, attempt to find a BasePart and set it as the PrimaryPart
            local primaryPart = model:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                model.PrimaryPart = primaryPart
                model:PivotTo(CFrame.new(targetPosition))
            else
                -- If no BasePart is found, you may need to adjust each part manually
                warn("No BasePart found in the model. Please set the model's position manually.")
            end
        end
    elseif model:IsA("BasePart") then
        -- If the loaded object is a BasePart, set its position directly
        model.Position = targetPosition
    else
        warn("Loaded object is neither a Model nor a BasePart.")
    end
else
    warn("Failed to load the asset with ID " .. assetID)
end
