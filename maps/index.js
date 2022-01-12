let mylocation=[]//-1.2914744690454036, 36.824757359046416
if(navigator.geolocation){
    navigator.geolocation.getCurrentPosition(showPosition,getError)
}

function showPosition(position) {
    let latitude=position.coords.latitude,
        longitude=position.coords.longitude
    mylocation.push(latitude,longitude)
    showMap()
}

function getError(err){
    console.log(`Sorry could not get your location: ${err}`)
}

function showMap(){
    let map = L.map('mymap').setView(mylocation, 15)

    let osm= L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 15,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        })
    let mapBoxStreet=L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYWtlbGxvcmljaCIsImEiOiJja3liNGhvY3owYm1tMm5uMG4xcmJhZ3E0In0.TkIMpkQIG1fNBf1o4fKCUg', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1IjoiYWtlbGxvcmljaCIsImEiOiJja3liNGhvY3owYm1tMm5uMG4xcmJhZ3E0In0.TkIMpkQIG1fNBf1o4fKCUg'
    })

    let googleStreets =L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
        maxZoom: 20,
        subdomains:['mt0','mt1','mt2','mt3']
    })

    let googleHybrid = L.tileLayer('http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',{
        maxZoom: 20,
        subdomains:['mt0','mt1','mt2','mt3']
    })

    googleStreets.addTo(map)

    // add a marker
    let marker = L.marker(mylocation).addTo(map);
    // bind popup to the marker
    marker.bindPopup("The technical university of Kenya").openPopup()
    // // add a popup 
    // let popup = L.popup()
    //     .setLatLng(mylocation)
    //     .setContent("Technical University Of Kenya")
    //     .openOn(map);

}





