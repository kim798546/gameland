package com.example.imple.game.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.example.imple.game.avoid.mapper.RecordMapper;
import com.example.imple.game.avoid.model.Record;

@SpringBootTest
public class RecordMapperTest {
	
	@Autowired
	RecordMapper mapper;
	
	@Test
	void select() {
		var list = mapper.selectPageByGameLevel(3);
		System.out.println(list);
	}
	
	@Test
	void countAllOfxLevel() {
		var cnt = mapper.countAllOfxLevel(1);
		System.out.println(cnt);
		cnt = mapper.countAllOfxLevel(2);
		System.out.println(cnt);
		cnt = mapper.countAllOfxLevel(3);
		System.out.println(cnt);
	}
	
	@Test
	void selectLastRowOfxLevel() {
		var record = mapper.selectLastRowOfxLevel(1);
		System.out.println(record);
		record = mapper.selectLastRowOfxLevel(2);
		System.out.println(record);
		record = mapper.selectLastRowOfxLevel(3);
		System.out.println(record);
	}
	
	@Test
	@Transactional
	void deleteMinRecordOfxLevel() {
		System.out.println(mapper.selectLastRowOfxLevel(2));
		System.out.println(mapper.selectAllOfxLevel(2));
		mapper.deleteMinRecordOfxLevel(2);
		System.out.println(mapper.selectAllOfxLevel(2));
	}
	
	@Test
	@Transactional
	void insertRecord() {
		var record = Record.builder()
						   .userName("xyz")
						   .score(100)
						   .elapseTime(50)
						   .build();
		var cnt = mapper.insertRecord(record);
		System.out.println(cnt);
	}
}
