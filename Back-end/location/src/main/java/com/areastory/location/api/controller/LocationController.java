package com.areastory.location.api.controller;

import com.areastory.location.api.service.LocationService;
import com.areastory.location.dto.common.LocationDto;
import com.areastory.location.dto.response.LocationResp;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Slf4j
public class LocationController {
    private final LocationService locationService;

    @PostMapping("/map")
    public ResponseEntity<List<LocationResp>> getMap(@RequestBody List<LocationDto> locationList) {
        try {
            for (LocationDto locationDto : locationList) {
                log.info("---------------------------------------------------------------------------------------------");
                log.info(locationDto.getDosi() + " " + locationDto.getSigungu() + " " + locationDto.getDongeupmyeon());
                log.info("---------------------------------------------------------------------------------------------");
            }
            List<LocationResp> resps = locationService.getMapImages(locationList);
            System.out.println(resps.get(0).getArticleId());
            System.out.println(resps.get(0).getLocationDto().getDosi());
            System.out.println(resps.get(0).getLocationDto().getSigungu());
            System.out.println(resps.get(0).getLocationDto().getDongeupmyeon());
            return ResponseEntity.ok(resps);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("뭔가 잘못됨 ㅋㅋ");
            return ResponseEntity.noContent().build();
        }
    }

    @PostMapping("/map/{userId}")
    public ResponseEntity<List<LocationResp>> getUserMap(@PathVariable Long userId, @RequestBody List<LocationDto> locationList) {
        try {
            System.out.println("userId: " + userId);
            return ResponseEntity.ok(locationService.getUserMapImages(userId, locationList));
        } catch (Exception e) {
            System.out.println("뭔가 잘못됨 ㅋㅋ");
            return ResponseEntity.noContent().build();
        }
    }
}