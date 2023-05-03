package com.areastory.user.db.entity;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@Table(name = "article", indexes = @Index(name = "idx_user_id", columnList = "user_id, article_id"))
public class Article {

    @Id
    @Column(name = "article_id")
    private Long articleId;
    @Setter
    @Column(length = 100)
    private String content;
    @Column(length = 200)
    private String image;
    @Setter
    private Long totalLikeCount;
    @Setter
    private Long commentCount;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
    private LocalDateTime createdAt;

    public Article(String content, String image, User user) {
        this.content = content;
        this.image = image;
        this.user = user;
    }
}
