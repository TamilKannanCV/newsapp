import 'dart:convert';

class IpData {
	String? status;
	String? country;
	String? countryCode;
	String? region;
	String? regionName;
	String? city;
	String? zip;
	double? lat;
	double? lon;
	String? timezone;
	String? isp;
	String? org;
	String? as;
	String? query;

	IpData({
		this.status, 
		this.country, 
		this.countryCode, 
		this.region, 
		this.regionName, 
		this.city, 
		this.zip, 
		this.lat, 
		this.lon, 
		this.timezone, 
		this.isp, 
		this.org, 
		this.as, 
		this.query, 
	});

	@override
	String toString() {
		return 'IpData(status: $status, country: $country, countryCode: $countryCode, region: $region, regionName: $regionName, city: $city, zip: $zip, lat: $lat, lon: $lon, timezone: $timezone, isp: $isp, org: $org, as: $as, query: $query)';
	}

	factory IpData.fromMap(Map<String, dynamic> data) => IpData(
				status: data['status'] as String?,
				country: data['country'] as String?,
				countryCode: data['countryCode'] as String?,
				region: data['region'] as String?,
				regionName: data['regionName'] as String?,
				city: data['city'] as String?,
				zip: data['zip'] as String?,
				lat: (data['lat'] as num?)?.toDouble(),
				lon: (data['lon'] as num?)?.toDouble(),
				timezone: data['timezone'] as String?,
				isp: data['isp'] as String?,
				org: data['org'] as String?,
				as: data['as'] as String?,
				query: data['query'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'status': status,
				'country': country,
				'countryCode': countryCode,
				'region': region,
				'regionName': regionName,
				'city': city,
				'zip': zip,
				'lat': lat,
				'lon': lon,
				'timezone': timezone,
				'isp': isp,
				'org': org,
				'as': as,
				'query': query,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [IpData].
	factory IpData.fromJson(String data) {
		return IpData.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [IpData] to a JSON string.
	String toJson() => json.encode(toMap());
}
