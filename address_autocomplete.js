async function addressAutocomplete(query) {
    const response = await fetch('https://photon.komoot.de/api/?q=' + query);
    const date = await response.json();
    let result = [];
    if (date.features !== undefined && Array.isArray(date.features)) {
        for (const feature of date.features) {
            const properties = feature.properties;
            if (properties !== undefined && properties.extent !== undefined
                && Array.isArray(properties.extent) && properties.extent.length === 4) {
                let name_parts = [];
                if (properties.name !== undefined) {
                    name_parts.push(properties.name)
                }
                if (properties.city !== undefined) {
                    name_parts.push(properties.city)
                }
                if (properties.state !== undefined) {
                    name_parts.push(properties.state)
                }
                if (properties.country !== undefined) {
                    name_parts.push(properties.country)
                }
                if (name_parts.length !== 0) {
                    result.push({
                        "name": name_parts.join(', '),
                        "lat1": properties.extent[0],
                        "lng1": properties.extent[1],
                        "lat2": properties.extent[2],
                        "lng2": properties.extent[3],
                    })
                }
            }
        }
    }
    return result;
}
