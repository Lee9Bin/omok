package com.gyub.omok.member.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private String Id;
    private String password;
    private String nickName;
    private String joinDate;

}
