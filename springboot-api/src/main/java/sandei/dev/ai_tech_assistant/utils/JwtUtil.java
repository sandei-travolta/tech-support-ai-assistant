package sandei.dev.ai_tech_assistant.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

@Component
public class JwtUtil {
    @Value("${jwt.secret}")
    private String secreat;
    @Value("${jwt.expiration}")
    private long expiration;

    public String generateToken(UUID uid){
        return Jwts
                .builder()
                .setSubject(String.valueOf(uid))
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis()+expiration))
                .signWith(Keys.hmacShaKeyFor(secreat.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }
    public String extractUsername(String token){
        return getClaims(token).getSubject();
    }
    public boolean isTokenValid(String token, String username) {
        return extractUsername(token).equals(username)
                && !getClaims(token).getExpiration().before(new Date());
    }
    private Claims getClaims(String token){
        return Jwts.parserBuilder()
                .setSigningKey(Keys.hmacShaKeyFor(secreat.getBytes()))
                .build()
                .parseClaimsJwt(token)
                .getBody();
    }
}
