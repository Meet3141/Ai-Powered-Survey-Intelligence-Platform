from sqlalchemy import select
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.deps import get_db
from app.models.community import Community, CommunityMember
from app.models.similarity import StudentRecommendation

router = APIRouter(prefix="", tags=["students"])


@router.get("/student/{student_id}/matches")
def get_student_matches(student_id: str, db: Session = Depends(get_db)):
    rows = (
        db.execute(
            select(StudentRecommendation)
            .where(StudentRecommendation.student_id == student_id)
            .order_by(StudentRecommendation.rank.asc())
        )
        .scalars()
        .all()
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No matches found for student")
    return [
        {
            "matched_student_id": row.matched_student_id,
            "matched_student_name": row.matched_student_name,
            "similarity_score": row.similarity_score,
            "recommendation_text": row.recommendation_text,
        }
        for row in rows
    ]


@router.get("/student/{student_id}/communities")
def get_student_communities(student_id: str, db: Session = Depends(get_db)):
    rows = (
        db.execute(select(CommunityMember).where(CommunityMember.student_id == student_id))
        .scalars()
        .all()
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No communities found for student")

    community_ids = [row.community_id for row in rows]
    communities = db.execute(select(Community).where(Community.id.in_(community_ids))).scalars().all()
    community_lookup = {community.id: community for community in communities}

    return {
        "student_id": student_id,
        "communities": [
            {
                "id": member.community_id,
                "community_key": community_lookup[member.community_id].community_key,
                "name": community_lookup[member.community_id].name,
                "membership_weight": member.membership_weight,
            }
            for member in rows
            if member.community_id in community_lookup
        ],
    }
