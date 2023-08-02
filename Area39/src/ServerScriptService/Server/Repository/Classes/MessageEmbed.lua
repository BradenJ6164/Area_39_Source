--[[
    A simple class that allows roblox developers to easily send messages to discord

    @author tomspell
    @author https://www.roblox.com/users/9345226/profile
    @version 1.0
    @version Last Updated: 6/20/2020
]]

local HttpService = game:GetService("HttpService")

local MessageEmbed = {}
MessageEmbed.__index = MessageEmbed
MessageEmbed.package = {
    embeds = {}
}

--[[
    Creates a message embed object

    @param webhook The webhook of the channel you want the message to be sent to

    @return message embed object
]]

function MessageEmbed.new(webhook)
    assert(typeof(webhook) == "string", "webhook must be a string")

    local object = {}
    object.__index = object
    object.webhook = webhook
    object.embed = { fields = {} }

    setmetatable(object, MessageEmbed)
    return object
end

--[[
    Adds a field to the embed (max 25).

    @param name [String] The name of the field
    @param value [String] The description of the field
    @param inline? [Boolean] A boolean of if the field should be inline with the other fields, defaults to false
]] 

function MessageEmbed:AddField(name, value, inline)
    assert(typeof(name) == "string", "name must be a string")
    assert(typeof(value) == "string", "value must be a string")
    if inline == nil then
        inline = false
    else
        assert(typeof(inline) == "boolean", "inline must be a boolean")
    end
    table.insert(self.embed.fields, {
        name = name,
        value = value,
        inline = inline
    })
end

--[[
    Adds multiple fields at a time (max 25)

    @param fields [Table] takes in a table of fields, example:
    local fieldsToAdd = {
        {"testing", "other testing"},
        {"more testing", "even more testing"}
    }

]]
function MessageEmbed:AddFields(fields)
    assert(typeof(fields) == "table", "fields must be a table")
    for _, field in pairs(fields) do
        assert(typeof(field) == "table", "the individual fields within the fields table must be tables")
        self:AddField(field[1], field[2], field[3])
    end
end

--[[
    Sets the title of the embed

    @param title [String] the title of the embed
]]

function MessageEmbed:SetTitle(title)
    assert(typeof(title) == "string", "title must be a string")
    self.embed.title = title
end

--[[
    Sets the description of the embed

    @param description [String] the description of the embed
]]

function MessageEmbed:SetDescription(description)
    assert(typeof(description) == "string", "description must be a string")
    self.embed.description = description
end

--[[
    Sets the url of the embed

    @param url [String] the url of the embed
]]

function MessageEmbed:SetUrl(url)
    assert(typeof(url) == "string", "url must be a string")
    self.embed.url = url
end

--[[
    Sets the color of the embed

    @param color [Number] the color of the embed (must be a decimal code, you can find them here: https://convertingcolors.com/)
]]

function MessageEmbed:SetColor(color)
    assert(typeof(color) == "number", "color must be a number")
    self.embed.color = color
end

--[[
    Sets the footer of the embed

    @param text [String] the text of the footer
    @param icon_url? [String] the url of the icon of the footer
]]

function MessageEmbed:SetFooter(text, icon_url)
    assert(typeof(text) == "string", "text must be a string")
    if icon_url ~= nil then
        assert(typeof(icon_url) == "string", "icon_url must be a string")
    end
    self.embed.footer = {
        text = text,
        icon_url = icon_url
    }
end

--[[
    Sets the image of the embed

    @param url [String] the url of the image
    @param proxy_icon_url? [String] The optional proxy_icon_url of the image
    @param height? [Number] the height of the image
    @param width? [Number] the width of the image
]]

function MessageEmbed:SetImage(url, proxy_icon_url, height, width)
    assert(typeof(url) == "string", "url must be a string")
    if proxy_icon_url ~= nil then
        assert(typeof(proxy_icon_url) == "string", "proxy_icon_url must be a string")
    end
    if height ~= nil then
        assert(typeof(height) == "number", "height must be a number")
    end
    if width ~= nil then
        assert(typeof(width) == "number", "width must be a number")
    end
    self.embed.image = {
        url = url,
        proxy_icon_url = proxy_icon_url,
        height = height,
        width = width
    }
end

--[[
    Sets the thumbnail of the embed

    @param url [String] the url of the thumbnail
    @param proxy_icon_url? [String] The optional proxy_icon_url of the thumbnail
    @param height? [Number] the height of the thumbnail
    @param width? [Number] the width of the thumbnail
]]

function MessageEmbed:SetThumbnail(url, proxy_icon_url, height, width)
    assert(typeof(url) == "string", "url must be a string")
    if proxy_icon_url ~= nil then
        assert(typeof(proxy_icon_url) == "string", "proxy_icon_url must be a string")
    end
    if height ~= nil then
        assert(typeof(height) == "number", "height must be a number")
    end
    if width ~= nil then
        assert(typeof(width) == "number", "width must be a number")
    end
    self.embed.thumbnail = {
        url = url,
        proxy_icon_url = proxy_icon_url,
        height = height,
        width = width
    }
end

--[[
    Sends the message asynchronously
]]

function MessageEmbed:PostAsync()
    table.insert(self.package.embeds, self.embed)
    coroutine.wrap(function()
        HttpService:PostAsync(self.webhook, HttpService:JSONEncode(self.package))
    end)()
end

return MessageEmbed