AMB.HTTP = AMB.HTTP or {}

-- -------------------------------------------------------------------------------------
local A = AMB.Ambition
local Fetch, Post = http.Fetch, http.Post
-- -------------------------------------------------------------------------------------
local requests = {}

function AMB.HTTP.Post( sUrl, tParameters, fOnSuccess, fOnFailure, tHeaders )
    if not sUrl then A.Error( 'HTTP', 'Post | sUrl is not selected!' ) end

    requests[ #requests + 1 ] = { type = 'POST', url = sUrl, param = tParameters, success = fOnSuccess, failure = fOnFailure, headers = tHeaders, time = os.time() }

    return Post( sUrl, tParameters, fOnSuccess, fOnFailure, tHeaders )
end

function AMB.HTTP.Get( sUrl, fOnSuccess, fOnFailure, tHeaders )
    if not sUrl then A.Error( 'HTTP', 'Get | sUrl is not selected!' ) end
    
    requests[ #requests + 1 ] = { type = 'GET', url = sUrl, success = fOnSuccess, failure = fOnFailure, headers = tHeaders, time = os.time() }

    return Fetch( sUrl, fOnSuccess, fOnFailure, tHeaders )
end

function AMB.HTTP.GetRequests()
    return requests
end