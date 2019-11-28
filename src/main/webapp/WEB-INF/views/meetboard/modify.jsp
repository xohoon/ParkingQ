<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
	$('.topheader_subject_text').html('오시는거죠');
	function checkUpdate(){
		if(!document.updateInfo.mname.value){
			alert("모임 이름을 정해주세요");
			return false;
		}else if(!document.updateInfo.title.value){
			alert("모임 태그를 설정해 주세요");
			return false;
		}else if(!document.updateInfo.content.value){
			alert("모임 내용을 작성해 주세요");
			return false;
		}
	}
</script>

<!-- -----------------------------------script------------------------------------------------------- -->
<style>
.modifyAll{
	width: 100%;
}
</style>

<div class="modifyAll">
	<form role="form" action="/meetboard/modify" method="post" name="updateInfo" onsubmit="return checkUpdate()">
			<div class="card">
				<!-- head -->
				<div class="card-body">
					<!-- Dropzone image modify -->
					<div style="float:left;margin-right:30px;">
						<img class="img-thumbnail" id="meetboard_File" style="width:400px;height:310px;" src="/local_img/meetboard/${board.mfile }">
					</div>
					<div>
						<div class="form-group" style="margin-top:15px;">
							<label><h5>모임 이름</h5></label>
							<input class="form-control" name="mname" value='<c:out value="${board.mname }"/>' style="width:780px;maring-top:10px;">
						</div>
						<div class="form-group">
							<label><h5>모임 태그</h5></label>
							<input class="form-control" name="title" value='<c:out value="${board.title }"/>' style="width:780px;">
						</div> 
						<div class="form-group">
							<label><h5>모임 장</h5></label>
							<input class="form-control" name="nick" value='<c:out value="${board.nick }"/>' readonly style="width:780px;background-color: #EEF5FA">
						</div>
					</div>
				</div>
				<!-- body -->
				<div class="card-header">
					<!-- Google Address Search -->
					<label><h5> 모임 장소</h5></label>
					<div id="map" style="width:1215px;height:450px"></div>
					<input id="pac-input" class="controls form-control" type="text" placeholder="장소 검색" style="width: 550px; height: 42px; margin-top: 9px; margin-left:190px;">
						<!-- Google map view -->
					</div>
				<div class="card-body">
					<div class="form-group">
						<label for="comment"><h4>모임 상세내용</h4></label>
						<textarea class="form-control" rows="5" id="comment" name='content' style="height:350px;">${board.content }</textarea>
					</div>
					<input type="hidden" name="no" value='<c:out value="${board.no }"/>' readonly="readonly">
					<input type="hidden" name="id" value="${board.id }">
					<!-- file name -->
					<input id="meetboard_filetext" type="hidden" name="mfile" readonly>
					<!-- map location info -->
					<input id="map_Lat" type="hidden" name="lat" readonly>
					<input id="map_Lng" type="hidden" name="lng" readonly>
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<div style="display:flex;justify-content:center;margin-bottom:25px;">
						<button id="button_submit" type="submit" data-oper='modify' class="btn btn-primary">수정완료</button>
						<button id="button_submit" type="submit" data-oper='remove' class="btn btn-danger" style="margin-left:15px;">모임삭제</button>
						<button id="button_submit" type="submit" data-oper='list' class="btn btn-info" style="margin-left:15px;">목록</button>
					</div>
				</div>
			</div>
	</form>
</div>



<!-- --------------------------------------bottom part is script----------------------------------------------------------------------------------------- -->

<script	type="text/javascript">
	$(document).ready(function(){
		var formObj = $("form");
		$('button').on("click", function(e){
			
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			
			if(operation === 'remove'){	
				formObj.attr("action" ,"/meetboard/remove");
			}else if(operation === 'list'){
				// move to list
				formObj.attr("action", "/meetboard/list").attr("method", "get");
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				self.location = "/meetboard/list";
				
			}
			formObj.submit();
		});
	});
</script>




<!-- Dropzone Image file upload -->
<script>

	$(function () {
		var obj = $("#meetboard_File");
	
	 obj.on('dragenter', function (e) {
	      e.stopPropagation();
	      e.preventDefault();
	      $(this).css('border', '4px solid #5272A0');
	 });
	
	 obj.on('dragleave', function (e) {
	      e.stopPropagation();
	      e.preventDefault();
	      $(this).css('border', '1px solid transparent');
	 });
	
	 obj.on('dragover', function (e) {
	      e.stopPropagation();
	      e.preventDefault();
	 });
	
	 obj.on('drop', function (e) {
	      e.preventDefault();
	      $(this).css('border', '1px solid transparent');
	
	      var files = e.originalEvent.dataTransfer.files;
	      var file = files[0];
	      
	      console.log(file);
	      console.log(file.name);
	      uploadMeetfile(file);
	 });
	
	});
/* 		
	function upload(){
		$.ajax({
            url: '/meetboard/uploadFile',
            type: 'post',
            data: formData,
            dataType: 'text',
            processData: false,
            contentType: false,
            success: function(data) {
                console.log('이미지 변경 >>> ' + data);
                $('#meetboard_File').attr('src',  '/local_img/meetboard/'+data);
                $('#meetboard_filetext').val(data);
		}
	});
} */
	// file upload
	
	function uploadMeetfile(file) {
		
		var formData = new FormData();
		formData.append("file", file);
	         
	         $.ajax({
	            url: '/meetboard/uploadFile',
	            type: 'post',
	            data: formData,
	            dataType: 'text',
	            processData: false,
	            contentType: false,
	            success: function(data) {
	                console.log('이미지 변경 >>> ' + data);
	                $('#meetboard_File').attr('src',  '/local_img/meetboard/'+data);
	                $('#meetboard_filetext').val(data);
	            }
	         });
	}
	
	
	
	$(document).ready(function(){
		uploadMeetfile();
	});

	</script>
	
<!-- Dropzone Image file upload -->

<!-- Google map upload -->

<script>
      function initMap() {
        
        var lat = 35.16273177463202;
        var lng = 129.04514129669803;
        
        var origin = {lat: lat, lng: lng};

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: origin
        });
        
        
        var marker = new google.maps.Marker({
          position: origin,
          map: map,
          title: 'Hello World!'
      });
        
        var clickHandler = new ClickEventHandler(map, origin);
      }

 function initAutocomplete() {
        
   var lat = 35.16273177463202;
   var lng = 129.04514129669803;
        
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: lat, lng: lng},
          zoom: 13,
         /*  mapTypeId: 'roadmap' */
        });

        // Create the search box and link it to the UI element.
        var input = document.getElementById('pac-input');
        var searchBox = new google.maps.places.SearchBox(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        // Bias the SearchBox results towards current map's viewport.
        map.addListener('bounds_changed', function() {
          searchBox.setBounds(map.getBounds());
        });

        var markers = [];
        // Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener('places_changed', function() {
          var places = searchBox.getPlaces();

          if (places.length == 0) {
            return;
          }

          // Clear out the old markers.
          markers.forEach(function(marker) {
            marker.setMap(null);
          });
          markers = [];

          // For each place, get the icon, name and location.
          var bounds = new google.maps.LatLngBounds();
          places.forEach(function(place) {
            if (!place.geometry) {
              console.log("Returned place contains no geometry");
              return;
            }
            var icon = {
              url: place.icon,
              size: new google.maps.Size(10, 10),
              origin: new google.maps.Point(0, 0),
              anchor: new google.maps.Point(0, 0),
              scaledSize: new google.maps.Size(25, 25)
            };

            // Create a marker for each place.
            markers.push(new google.maps.Marker({
              map: map,
              icon: icon,
              title: place.name,
              position: place.geometry.location
            }));

            if (place.geometry.viewport) {
              // Only geocodes have viewport.
              bounds.union(place.geometry.viewport);
            } else {
              bounds.extend(place.geometry.location);
            }
          });
          map.fitBounds(bounds);
        });
        
        
        var clickHandler = new ClickEventHandler(map, origin);
      }
      
      
      
      /**
       * @constructor
       */
      var ClickEventHandler = function(map, origin) {
        this.origin = origin;
        this.map = map;
        this.directionsService = new google.maps.DirectionsService;
        this.directionsDisplay = new google.maps.DirectionsRenderer;
        this.directionsDisplay.setMap(map);
        this.placesService = new google.maps.places.PlacesService(map);
        this.infowindow = new google.maps.InfoWindow;
        this.infowindowContent = document.getElementById('infowindow-content');
        this.infowindow.setContent(this.infowindowContent);

        // Listen for clicks on the map.
        this.map.addListener('click', this.handleClick.bind(this));
      };
      

      ClickEventHandler.prototype.handleClick = function(event) {
        console.log('click ' + event.latLng);
        
        var value = event.latLng.toString();
        var result = value.substring(1,value.length-1);
        var array = result.split(',');
        var lat = array[0];
        var lng = array[1].substring(1,array[1].length);
        console.log(lat + " : " + lng);
        
        $('#map_Lat').val(lat);
        $('#map_Lng').val(lng);
        
        var textval = event.latLng;
        /* document.getElementById("textval").innerHTML = "<i class='fas fa-map-marker-alt' style='font-size:15px; margin-right: 5px; vertical-align: 1px;'></i>"+"선택된 위치 : "+event.latLng;
         */
        
        // If the event has a placeId, use it.
        if (event.placeId) {
          console.log('You clicked on place:' + event.placeId);

          // Calling e.stop() on the event prevents the default info window from
          // showing.
          // If you call stop here when there is no placeId you will prevent some
          // other map click event handlers from receiving the event.
          event.stop();
          this.calculateAndDisplayRoute(event.placeId);
          this.getPlaceInformation(event.placeId);
        }
      };

      ClickEventHandler.prototype.calculateAndDisplayRoute = function(placeId) {
        var me = this;
        this.directionsService.route({
          origin: this.origin,
          destination: {placeId: placeId},
          travelMode: 'WALKING'
        }, function(response, status) {
          if (status === 'OK') {
            me.directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      };

      ClickEventHandler.prototype.getPlaceInformation = function(placeId) {
        var me = this;
        this.placesService.getDetails({placeId: placeId}, function(place, status) {
          if (status === 'OK') {
            me.infowindow.close();
            me.infowindow.setPosition(place.geometry.location);
            me.infowindowContent.children['place-icon'].src = place.icon;
            me.infowindowContent.children['place-name'].textContent = place.name;
            me.infowindowContent.children['place-id'].textContent = place.place_id;
            me.infowindowContent.children['place-address'].textContent =
            place.formatted_address;
            me.infowindow.open(me.map);
          }
        });
      };
      

    </script>
    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyByjX-fIiEVgNTofLuWWpxgGqQADaoNSWk&libraries=places&callback=initAutocomplete" async defer></script>


	<!-- Google map upload -->







