package org.zerock.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Service;
import org.zerock.domain.FootprintsVO;
import org.zerock.mapper.IntroduceMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class IntroduceServiceImpl implements IntroduceService {

	IntroduceMapper introduceMapper;
	
	@Override
	public Map<String, List<FootprintsVO>> get() {
		
		List<FootprintsVO> footDBList = introduceMapper.get();
		Map<String, List<FootprintsVO>> footprintsMap = new TreeMap<String, List<FootprintsVO>>(Collections.reverseOrder());
		
		for(int i=0; i < footDBList.size(); i++) {
			log.info(footDBList.get(i).getYear());
			footprintsMap.put(footDBList.get(i).getYear(), null);
		}

		for( String key : footprintsMap.keySet() ) {
			List<FootprintsVO> imsiList = new ArrayList<FootprintsVO>();
			for(int i=0; i < footDBList.size(); i++) {
				if( key.equals(footDBList.get(i).getYear()) ) {
					imsiList.add(footDBList.get(i));
				}
			}
			footprintsMap.put(key, imsiList);
		}
		log.info(footprintsMap);
		return footprintsMap;
	}

}
