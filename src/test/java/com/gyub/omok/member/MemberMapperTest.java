package com.gyub.omok.member;

import com.gyub.omok.member.entity.Member;
import com.gyub.omok.member.mapper.MemberMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberMapperTest {

    @Autowired
    private MemberMapper mapper;

    @Test
    void 회원가입(){
        //given
        Member member = new Member("test", "1234", "테스트", null);
        //when
        mapper.insert(member);
        //then

    }

}
