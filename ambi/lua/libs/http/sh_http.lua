Ambi.HTTP = Ambi.HTTP or {}

-- -------------------------------------------------------------------------------------
local Gen = Ambi.General
local Fetch, Post = http.Fetch, http.Post
-- -------------------------------------------------------------------------------------
local requests = {}

function Ambi.HTTP.Post( sUrl, tParameters, fOnSuccess, fOnFailure, tHeaders )
    if not sUrl then Gen.Error( 'HTTP', 'Post | sUrl is not selected!' ) end

    requests[ #requests + 1 ] = { type = 'POST', url = sUrl, param = tParameters, success = fOnSuccess, failure = fOnFailure, headers = tHeaders, time = os.time() }

    return Post( sUrl, tParameters, fOnSuccess, fOnFailure, tHeaders )
end

function Ambi.HTTP.Get( sUrl, fOnSuccess, fOnFailure, tHeaders )
    if not sUrl then Gen.Error( 'HTTP', 'Get | sUrl is not selected!' ) end
    
    requests[ #requests + 1 ] = { type = 'GET', url = sUrl, success = fOnSuccess, failure = fOnFailure, headers = tHeaders, time = os.time() }

    return Fetch( sUrl, fOnSuccess, fOnFailure, tHeaders )
end

function Ambi.HTTP.GetRequests()
    return requests
end