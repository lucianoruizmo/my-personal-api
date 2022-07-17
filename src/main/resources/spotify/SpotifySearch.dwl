import * from dw::core::Periods

fun returnSpotifySearchData(payload) = {
	(artists: formatArtists(payload.artists.items)) if (!isEmpty(payload.artists.items)),
	(albums: formatAlbums(payload.albums.items)) if (!isEmpty(payload.albums.items)),
	(tracks: formatTracks(payload.tracks.items)) if (!isEmpty(payload.tracks.items))
}

fun formatArtists(artists) = 
	artists map (value, index) -> {
		name: value.name,
		totalFollowers: value.followers.total,
		genres: value.genres,
		url: value.external_urls.spotify
	}
	
fun formatAlbums(albums) =
	albums map (value, index) -> {
		name: value.name,
		"type": value.album_type,
		artist: value.artists[0].name,
		releaseDay: value.release_date,
		totalTracks: value.total_tracks,
		url: value.external_urls.spotify
	}
	
fun formatTracks(tracks) =
	tracks map (value, index) -> {
		name: value.name,
		album: value.album.name,
		artist: value.album.artists[0].name,
		duration: ((0 as DateTime) + seconds(value.duration_ms / 1000)) as String {format: "mm:ss"} default null,
		explicit: value.explicit,
		url: value.external_urls.spotify
	}