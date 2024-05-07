package com.gyub.omok.member.mapper;

import com.gyub.omok.member.entity.Member;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    boolean login(Member member);

    void insert(Member member);

    void delete(String id);

    void update(String id, Member member);

    Member findById(String id);

}
